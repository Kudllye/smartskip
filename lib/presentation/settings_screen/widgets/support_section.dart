import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class SupportSection extends StatefulWidget {
  const SupportSection({super.key});

  @override
  State<SupportSection> createState() => _SupportSectionState();
}

class _SupportSectionState extends State<SupportSection> {
  final List<Map<String, dynamic>> _faqData = [
    {
      "question": "¿Cómo activo el servicio de Smart Skip?",
      "answer":
          "Toca el botón principal en la pantalla de inicio para activar el servicio. La aplicación te guiará para otorgar los permisos de accesibilidad necesarios.",
      "isExpanded": false,
    },
    {
      "question": "¿Por qué necesita permisos de accesibilidad?",
      "answer":
          "Smart Skip utiliza los servicios de accesibilidad para detectar automáticamente los botones 'Saltar anuncio' en YouTube y hacer clic en ellos por ti.",
      "isExpanded": false,
    },
    {
      "question": "¿La aplicación recopila mis datos?",
      "answer":
          "No. Smart Skip funciona completamente de forma local en tu dispositivo. No recopilamos, almacenamos ni compartimos ningún dato personal.",
      "isExpanded": false,
    },
    {
      "question": "¿Funciona sin conexión a internet?",
      "answer":
          "Sí, una vez activado, Smart Skip funciona sin necesidad de conexión a internet ya que todo el procesamiento se realiza localmente.",
      "isExpanded": false,
    },
    {
      "question": "¿Afecta el rendimiento de mi dispositivo?",
      "answer":
          "Smart Skip está optimizado para usar recursos mínimos del sistema y no debería afectar significativamente el rendimiento de tu dispositivo.",
      "isExpanded": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            'Soporte',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildFaqTile(),
              _buildDivider(),
              _buildContactTile(),
              _buildDivider(),
              _buildFeedbackTile(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFaqTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'quiz',
          color: AppTheme.lightTheme.colorScheme.secondary,
          size: 20,
        ),
      ),
      title: Text(
        'Preguntas Frecuentes',
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Encuentra respuestas a las dudas más comunes',
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: CustomIconWidget(
        iconName: 'expand_more',
        color: AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.4),
        size: 16,
      ),
      onTap: () => _showFaqBottomSheet(),
    );
  }

  Widget _buildContactTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'contact_support',
          color: AppTheme.lightTheme.colorScheme.tertiary,
          size: 20,
        ),
      ),
      title: Text(
        'Contactar Soporte',
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'support@smartskip.app',
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: CustomIconWidget(
        iconName: 'email',
        color: AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.4),
        size: 16,
      ),
      onTap: () => _launchEmail(),
    );
  }

  Widget _buildFeedbackTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'feedback',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        'Enviar Comentarios',
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Ayúdanos a mejorar Smart Skip',
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: CustomIconWidget(
        iconName: 'send',
        color: AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.4),
        size: 16,
      ),
      onTap: () => _launchFeedbackEmail(),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
      indent: 16.w,
    );
  }

  void _showFaqBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.only(top: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preguntas Frecuentes',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemCount: _faqData.length,
                itemBuilder: (context, index) {
                  final faq = _faqData[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 2.h),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faq["question"],
                        style:
                            AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Text(
                            faq["answer"],
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface
                                  .withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@smartskip.app',
      query:
          'subject=Smart Skip - Consulta de Soporte&body=Hola equipo de Smart Skip,%0A%0AEscribo para consultar sobre:%0A%0A[Describe tu consulta aquí]%0A%0AInformación del dispositivo:%0A- Versión de la app: 1.2.3%0A- Dispositivo: ${_getDeviceInfo()}%0A%0AGracias.',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('No se pudo abrir la aplicación de correo');
      }
    } catch (e) {
      _showErrorSnackBar('Error al abrir el correo electrónico');
    }
  }

  void _launchFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'feedback@smartskip.app',
      query:
          'subject=Smart Skip - Comentarios y Sugerencias&body=Hola equipo de Smart Skip,%0A%0AMe gustaría compartir los siguientes comentarios:%0A%0A[Escribe tus comentarios aquí]%0A%0A¿Qué te gusta más de Smart Skip?%0A[Tu respuesta]%0A%0A¿Qué mejorarías?%0A[Tu respuesta]%0A%0A¿Recomendarías Smart Skip a otros?%0A[Tu respuesta]%0A%0AInformación del dispositivo:%0A- Versión de la app: 1.2.3%0A- Dispositivo: ${_getDeviceInfo()}%0A%0A¡Gracias por ayudarnos a mejorar!',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('No se pudo abrir la aplicación de correo');
      }
    } catch (e) {
      _showErrorSnackBar('Error al abrir el correo electrónico');
    }
  }

  String _getDeviceInfo() {
    return 'Android/iOS'; // Simplified device info
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
