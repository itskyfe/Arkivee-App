import 'package:flutter/material.dart';
import '../models/surat_model.dart';

class SuratCard extends StatelessWidget {

  final Surat surat;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const SuratCard({
    super.key,
    required this.surat,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  Color kategoriColor(){

    if(surat.kategori=="Masuk"){
      return Colors.green;
    }else{
      return Colors.orange;
    }

  }

  @override
  Widget build(BuildContext context){

    return Card(

      elevation:2,
      margin: const EdgeInsets.symmetric(vertical:8),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: InkWell(

        onTap:onTap,

        borderRadius: BorderRadius.circular(12),

        child: Padding(

          padding: const EdgeInsets.all(12),

          child: Row(

            children:[

              Container(

                width:50,
                height:50,

                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: const Icon(
                  Icons.mail,
                  color: Colors.blue,
                ),

              ),

              const SizedBox(width:12),

              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:[

                    Text(
                      surat.perihal,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:15,
                      ),
                    ),

                    const SizedBox(height:4),

                    Text(
                      surat.nomor,
                      style: const TextStyle(color:Colors.grey),
                    ),

                    const SizedBox(height:4),

                    Text(
                      surat.asalTujuan,
                      style: const TextStyle(fontSize:12),
                    ),

                    const SizedBox(height:6),

                    Row(

                      children:[

                        Container(

                          padding: const EdgeInsets.symmetric(
                            horizontal:8,
                            vertical:3,
                          ),

                          decoration: BoxDecoration(
                            color:kategoriColor(),
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Text(

                            surat.kategori,

                            style: const TextStyle(
                              color:Colors.white,
                              fontSize:11,
                            ),

                          ),

                        ),

                        const SizedBox(width:10),

                        Text(

                          "${surat.tanggal.day}/${surat.tanggal.month}/${surat.tanggal.year}",

                          style: const TextStyle(
                            fontSize:11,
                            color:Colors.grey,
                          ),

                        ),

                      ],

                    )

                  ],

                ),

              ),

              Column(

                children:[

                  IconButton(
                    icon: const Icon(Icons.edit,color:Colors.blue),
                    onPressed:onEdit,
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete,color:Colors.red),
                    onPressed:onDelete,
                  ),

                ],

              )

            ],

          ),

        ),

      ),

    );

  }

}