/* window.vala
 *
 * Copyright 2023 Kaylie
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Banana {
    [GtkTemplate (ui = "/com/lunakittyyy/Banana/onboarding/onboarding-window.ui")]
    public class OnboardingWindow : Adw.Window {
        [GtkChild] private unowned Gtk.Button chooseDirButton;
        [GtkChild] private unowned Gtk.Button onboardingHeaderNext;
        [GtkChild] private unowned Gtk.Button installBepButton;
        [GtkChild] private unowned Gtk.Button onboardingHeaderSkip;
        [GtkChild] private unowned Adw.HeaderBar header_bar;
        [GtkChild] private unowned Gtk.Stack onboardStack;
        public File folder;

        public OnboardingWindow (Application app, Gtk.Window win) {
            Object (transient_for: win);
        }

        public async void openFileDialog () {
            try {
                var fileDialog = new Gtk.FileDialog ();
                folder = yield fileDialog.select_folder (this, Cancellable.get_current ());
                onGameChosen (folder);
            } catch (Error err) { }
        }

        private void onGameChosen (File folder) {
            print(folder.get_path () + "\n");
            onboardingHeaderNext.set_sensitive (true);
        }

        construct {
            onboardStack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
            onboardingHeaderNext.set_sensitive (false);

            chooseDirButton.clicked.connect (() => {
			    openFileDialog ();
		    });

		    installBepButton.clicked.connect (() => {
                print ("Downloading BepInEx to be implemented soon");
		    });

            onboardingHeaderSkip.clicked.connect (() => {
               close ();
            });

		    onboardingHeaderNext.clicked.connect (() => {
			    switch (onboardStack.get_visible_child_name ()) {
                    case "chooseGame":
                        onboardStack.visible_child_name = "bepInstall";
                }
                onboardingHeaderNext.set_sensitive (false);
		    });
        }
    }
}
