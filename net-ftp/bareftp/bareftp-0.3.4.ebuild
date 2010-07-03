# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/bareftp/bareftp-0.3.4.ebuild,v 1.1 2010/07/03 18:28:37 pacho Exp $

EAPI=2

inherit mono gnome2

DESCRIPTION="Mono based file transfer client"
HOMEPAGE="http://www.bareftp.org/"
SRC_URI="http://www.bareftp.org/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome-keyring"

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gtk-sharp-2.12
	>=dev-dotnet/gnome-sharp-2.20
	>=dev-dotnet/gnomevfs-sharp-2.20
	>=dev-dotnet/gconf-sharp-2.20
	gnome-keyring? ( >=dev-dotnet/gnome-keyring-sharp-1.0.0-r2 )"

DEPEND="${RDEPEND}"

pkg_setup() {
	G2CONF="--disable-caches
		$(use_with gnome-keyring gnomekeyring)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix tests, bug #279892
	echo "src/bareFTP.Gui.Dialog/AskFileAction.cs" >> po/POTFILES.in
	echo "src/bareFTP.Gui.Dialog/gtk-gui/bareFTP.Gui.Dialog.ChmodDialog.cs" >> po/POTFILES.in
	echo "src/bareFTP.Gui.Dialog/gtk-gui/bareFTP.Gui.Dialog.ExceptionDialog.cs" >> po/POTFILES.in
	echo "src/bareFTP.Gui.FileManager/FileUtils.cs" >> po/POTFILES.in
	echo "src/bareFTP.Gui.Preferences/BookmarkWidget.cs" >> po/POTFILES.in
	echo "src/bareFTP.Gui/BookmarkUtils.cs" >> po/POTFILES.in
	echo "src/bareFTP.Protocol.Sftp/sftp/SftpConnection.cs" >> po/POTFILES.in
	echo "src/bareFTP/Main.cs" >> po/POTFILES.in
}

src_install() {
	gnome2_src_install
	dodoc ChangeLog README || die "dodoc failed"
}
