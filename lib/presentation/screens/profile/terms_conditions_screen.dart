import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: kL,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    size: 60,
                    color: kWhiteColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Terms & Conditions',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: kWhiteColor,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please read these terms carefully',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: kWhiteColor.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Terms Content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: kBlackColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('1. Acceptance of Terms'),
                  _buildSectionContent(
                    'By accessing and using the ArchApprove application, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('2. Use License'),
                  _buildSectionContent(
                    'Permission is granted to temporarily download one copy of the application for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('3. User Account'),
                  _buildSectionContent(
                    'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account or password.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('4. Leave Management'),
                  _buildSectionContent(
                    'The application allows employees to apply for various types of leave including casual, annual, and sick leave. All leave applications are subject to approval by authorized personnel.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('5. Data Privacy'),
                  _buildSectionContent(
                    'We are committed to protecting your privacy. Your personal information will be used only for the purposes for which it was collected and will not be shared with third parties without your consent.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('6. Prohibited Uses'),
                  _buildSectionContent(
                    'You may not use the application for any unlawful purpose or to solicit others to perform unlawful acts. You may not violate any international, federal, provincial, or state regulations.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('7. Disclaimer'),
                  _buildSectionContent(
                    'The materials on the application are provided on an \'as is\' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including without limitation, implied warranties or conditions of merchantability.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('8. Limitations'),
                  _buildSectionContent(
                    'In no event shall ArchApprove or its suppliers be liable for any damages arising out of the use or inability to use the materials on the application, even if we or our authorized representative has been notified.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('9. Revisions and Errata'),
                  _buildSectionContent(
                    'The materials appearing on the application could include technical, typographical, or photographic errors. We do not warrant that any of the materials are accurate, complete, or current.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('10. Links'),
                  _buildSectionContent(
                    'We have not reviewed all of the sites linked to our application and are not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('11. Modifications'),
                  _buildSectionContent(
                    'We may revise these terms of service for our application at any time without notice. By using this application, you are agreeing to be bound by the then current version of these Terms of Service.',
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('12. Governing Law'),
                  _buildSectionContent(
                    'These terms and conditions are governed by and construed in accordance with the laws and you irrevocably submit to the exclusive jurisdiction of the courts in that location.',
                  ),

                  const SizedBox(height: 32),

                  // Last Updated
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kLightSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: kLightSecondaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: kSecondaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Last updated: ${DateTime.now().year}',
                            style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Accept Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'You have accepted the Terms & Conditions',
                      ),
                      backgroundColor: kSuccessColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'I Accept',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 14, color: kDarkGreyColor, height: 1.5),
    );
  }
}
