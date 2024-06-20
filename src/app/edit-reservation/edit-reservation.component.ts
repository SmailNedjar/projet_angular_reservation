import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';

import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute, Router } from '@angular/router';
import { Utilisateur } from '../models/Utilisateur.type';
import { Reservation } from '../models/Reservation.type';
@Component({
  selector: 'app-edit-reservation',
  standalone: true,
  imports: [
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatButtonModule,
    MatSelectModule,
    HttpClientModule,
  ],
  templateUrl: './edit-reservation.component.html',
  styleUrl: './edit-reservation.component.scss',
})
export class EditReservationComponent {
  listeMateriel: any[] = [];

  formBuilder: FormBuilder = inject(FormBuilder);

  formulaire: FormGroup = this.formBuilder.group({
    date_debut: ['', [Validators.required]],
    date_fin_reel: ['', [Validators.required]],
    materiel: [null, [Validators.required]],
  });

  http: HttpClient = inject(HttpClient);
  snackBar: MatSnackBar = inject(MatSnackBar);
  router: Router = inject(Router);
  route: ActivatedRoute = inject(ActivatedRoute);


  idReservation?: number;

  ngOnInit() {

    const jwt = localStorage.getItem('jwt');

    if (jwt != null) {

      this.http
        .get<Reservation>(
          'https://localhost/backend_angular/back_end_ticketing_dw2/list_materiel.php'
          ,
          { headers: { Authorization: jwt } }
        )
        .subscribe({
          next: (listeMateriel: any) => {
            this.listeMateriel = listeMateriel;
          },
          error: () =>
            alert('Erreur inconnue contactez votre administrateur'),
        });

      this.route.params.subscribe((parametresUrl) => {
        //si il y a bien un parametre dans l'url et que c'est un nombre
        if (parametresUrl['id'] && !isNaN(parametresUrl['id'])) {
          //on créait un nouveau FormGroup dont le formsControl "password" n'a pas de validateur
          this.formulaire = this.formBuilder.group({
            date_debut: ['', [Validators.required]],
            date_fin_reel: ['', [Validators.required]],
            materiel: [null, [Validators.required]],
          });


          this.http
            .get<Reservation>(
              'https://localhost/backend_angular/back_end_ticketing_dw2/get-reservation.php?id=' +
              parametresUrl['id'],
              { headers: { Authorization: jwt } }
            )
            .subscribe({
              next: (reservation: Reservation) => {
                this.formulaire.patchValue(reservation);
                this.idReservation = reservation.id;
              },
              error: () =>
                alert('Erreur inconnue contactez votre administrateur'),
            });

        } else {
          this.formulaire = this.formBuilder.group({
            date_debut: ['', [Validators.required]],
            date_fin_reel: ['', [Validators.required]],
            materiel: [null, [Validators.required]],
          });
        }
      });
    }
  }

  onSubmit() {
    if (this.formulaire.valid) {
      const url: string =
        this.idReservation == null
          ? 'https://localhost/backend_angular/back_end_ticketing_dw2/add-reservation.php?'
          : 'https://localhost/backend_angular/back_end_ticketing_dw2/edit-reservation.php?id=' +
          this.idReservation;

      const jwt = localStorage.getItem('jwt');

      if (jwt != null) {
        this.http
          .post(url, this.formulaire.value, { headers: { Authorization: jwt } })
          .subscribe({
            next: (resultat) => {
              this.snackBar.open("La reservation a bien été ajouté", undefined, {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'top',
                panelClass: 'valid',
              });

              this.router.navigateByUrl('/manage-reservation');
            },
            error: (resultat) =>
              alert('Erreur inconnue contactez votre administrateur'),
          });
      }
    }
  }
}
