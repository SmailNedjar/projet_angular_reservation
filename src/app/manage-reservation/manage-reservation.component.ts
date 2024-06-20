import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { RouterLink } from '@angular/router';
import { Reservation } from '../models/Reservation.type';

import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatIconModule } from '@angular/material/icon';
import { MatSnackBar } from '@angular/material/snack-bar';
import { AuthentificationService } from '../authentification.service';

@Component({
  selector: 'app-manage-reservation',
  standalone: true,
  imports: [
    MatButtonModule,
    RouterLink,
    HttpClientModule,
    MatTableModule,
    MatPaginatorModule,
    MatIconModule,
  ],
  templateUrl: './manage-reservation.component.html',
  styleUrl: './manage-reservation.component.scss',
})
export class ManageReservationComponent {
  http: HttpClient = inject(HttpClient);
  snackBar: MatSnackBar = inject(MatSnackBar);
  authentification: AuthentificationService = inject(AuthentificationService);

  listeReservation: Reservation[] = [];

  ngOnInit() {
    this.refresh();

  }

  refresh() {
    const jwt = localStorage.getItem('jwt');

    if (jwt != null) {
      this.http
        .get<Reservation[]>(
          'https://localhost/backend_angular/back_end_ticketing_dw2/list-reservation.php',
          { headers: { Authorization: jwt } }
        )
        .subscribe((resultat) => (this.listeReservation = resultat));
    }
  }

  onSuppressionUtilisateur(idReservation: number) {
    const jwt = localStorage.getItem('jwt');

    if (jwt != null) {
      this.http
        .delete(
          'https://localhost/backend_angular/back_end_ticketing_dw2/delete-reservation.php?id=' +
            idReservation,
          { headers: { Authorization: jwt } }
        )
        .subscribe({
          next: (resultat) => {
            this.refresh();
            this.snackBar.open("La reservation a bien été supprimé", undefined, {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'top',
              panelClass: 'valid',
            });
          },
          error: (resultat) =>
            this.snackBar.open(
              'Erreur inconnue, contactez votre administrateur',
              undefined,
              {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'top',
                panelClass: 'error',
              }
            ),
        });
    }
  }
}
