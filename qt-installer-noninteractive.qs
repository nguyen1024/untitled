// http://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server

// Emacs mode hint: -*- mode: JavaScript -*-

//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

function Controller() {
    installer.autoRejectMessageBoxes();

    installer.setMessageBoxAutomaticAnswer("OverwriteTargetDirectory", QMessageBox.Yes);

    installer.setMessageBoxAutomaticAnswer("TargetDirectoryInUse", QMessageBox.NO);

    installer.installationFinished.connect(
        function() {
            gui.clickButton(buttons.NextButton);
        }
    )
}

//-------------------------------------------------------------------------------------------------
// Welcome Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Credentials Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Introduction Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Target Directory Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.TargetDirectoryPageCallback = function() {
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("/home/vagrant/Qt");

    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Component Select Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();
    widget.selectAll();

    //widget.deselectAll();
    //widget.selectComponent("qt.55.gcc_64");
    //widget.selectComponent("qt.55.qtquickcontrols");

    // widget.deselectComponent("qt.tools.qtcreator");
    // widget.deselectComponent("qt.55.qt3d");
    // widget.deselectComponent("qt.55.qtcanvas3d");
    // widget.deselectComponent("qt.55.qtlocation");
    // widget.deselectComponent("qt.55.qtquick1");
    // widget.deselectComponent("qt.55.qtscript");
    // widget.deselectComponent("qt.55.qtwebengine");
    // widget.deselectComponent("qt.extras");
    // widget.deselectComponent("qt.tools.doc");
    // widget.deselectComponent("qt.tools.examples");

    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// License Agreement Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Start Menu Directory Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Ready For Installation Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

//-------------------------------------------------------------------------------------------------
// Finished Page
//-------------------------------------------------------------------------------------------------

Controller.prototype.FinishedPageCallback = function() {
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
	   checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
