# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.29.ebuild,v 1.6 2006/12/03 15:20:38 pva Exp $

inherit eutils gnome2 mono

DESCRIPTION="Sussen is a tool that checks for vulnerabilities and configuration issues on computer systems"
HOMEPAGE="http://dev.mmgsecurity.com/projects/sussen/"
SRC_URI="http://dev.mmgsecurity.com/downloads//${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="doc dbus gnome"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

RDEPEND="=dev-lang/mono-1.1*
	gnome? ( >=dev-dotnet/gtk-sharp-2.4
			 >=dev-dotnet/gnome-sharp-2.4
			 >=dev-dotnet/gconf-sharp-2.4
			 >=dev-dotnet/glade-sharp-2.4
			 gnome-base/gnome-panel )
	dbus? ( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/monodoc-1.1.8 )
	app-arch/rpm
	>=dev-util/intltool-0.34.2"

DOCS="AUTHORS ChangeLog README TODO"

pkg_setup() {
	if use dbus ; then
		built_with_use -a sys-apps/dbus mono || die \
		"${PN} requires dbus build with mono support. Please, reemerge dbus with USE=\"mono\""
	fi
	use gnome || { elog "You do not have gnome in your USE flags.";
					elog "applet and editor will not be built." ; }
}

# src_unpack, pkg_postinst, pkg_postrm are exported in gnome2.eclass. But since
# we have gnome2 support depends on USE let's call gnome2.eclass internal
# functions only when USE="gnome".
src_unpack() {
	unpack ${A}
	cd ${S}

	use gnome && gnome2_omf_fix
}

src_compile () {
	# Put all asp pages in /usr/share/$PF dir instead of /usr/share/sussen
	sed -i -e \
	"s:wwwdir = \$(datadir)/doc/sussen/www/asp:wwwdir = \$(datadir)/doc/${PF}/www/asp:" \
	www/asp/Makefile.in || die "sed failed."

	econf ${myconf} \
		$(use_enable dbus) \
		$(use_enable gnome) || die "./configure failed."

	emake -j1 || die "Compilation failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"

	dodoc ${DOCS}

	if use gnome ; then
		elog "sussen-applet is a GNOME applet. You can not run it directly from"
		elog "the command line. Use GNOME panel to invoke it."
		elog "You can also run it with the --tray-icon command line option."
		echo
		ewarn "sussen-editor is still work in progress. Just basic functionality is"
		ewarn "working (New, Save, Execute)."
		echo
		ewarn "Beginning with sussen-0.24 default location for oval definitions changed."
		ewarn "If you had previous versions installed, please, run the following"
		ewarn "commands to clean outdated locations for each user that run sussen:"
		ewarn
		ewarn "gconftool-2 --unset /apps/sussen-applet/oval_xml_directory"
		ewarn "gconftool-2 --unset /apps/sussen-applet/oval_download_directory"
		echo
	fi
}

pkg_postinst() {
	use gnome && gnome2_pkg_postinst
}

pkg_postrm() {
	use gnome && gnome2_pkg_postrm
}
