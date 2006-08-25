# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.25-r1.ebuild,v 1.1 2006/08/25 06:13:38 pva Exp $

inherit eutils gnome2 mono autotools

DESCRIPTION="Sussen is a tool that checks for vulnerabilities and configuration issues on computer systems"
HOMEPAGE="http://dev.mmgsecurity.com/projects/sussen/"
SRC_URI="http://dev.mmgsecurity.com/downloads//${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="doc dbus"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="=dev-lang/mono-1.1*
	>=dev-dotnet/gtk-sharp-2.4
	>=dev-dotnet/gnome-sharp-2.4
	>=dev-dotnet/gconf-sharp-2.4
	>=dev-dotnet/glade-sharp-2.4
	gnome-base/gnome-panel
	dbus? ( sys-apps/dbus )"

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
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/sussen-0.25-0.28-interface-failsafe.diff
}

src_compile () {
	econf ${myconf} \
		$(use_enable dbus) || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}" \
	DESTDIR=${D} install || die

	dodoc ${DOCS}

	elog "sussen-applet is a GNOME applet. You can not run it directly from"
	elog "the command line. Use GNOME panel to invoke it."
	elog "You can also run it as the tray icon: sussen-applet --tray-icon"
	echo
	ewarn "sussen-editor is still work in progress. Just basic functionality is"
	ewarn "working (New, Save, Execute)."
	echo
	ewarn "Beginning with sussen-0.24 default location for oval definitions changed."
	ewarn "If you had previous versions installed, please, run the following"
	ewarn "commands to clean outdated locations for each users that ran sussen:"
	ewarn
	ewarn "gconftool-2 --unset /apps/sussen-applet/oval_xml_directory"
	ewarn "gconftool-2 --unset /apps/sussen-applet/oval_download_directory"
	echo
}
