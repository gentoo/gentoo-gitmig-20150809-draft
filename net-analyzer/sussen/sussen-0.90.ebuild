# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.90.ebuild,v 1.10 2012/05/04 06:08:08 jdhore Exp $

#WANT_AUTOCONF="latest"
#WANT_AUTOMAKE="1.8"
#inherit eutils gnome2 mono autotools

EAPI="2"
inherit gnome2 mono eutils

DESCRIPTION="Sussen is a tool that checks for vulnerabilities and configuration issues on computer systems"
HOMEPAGE="http://www.lbtechservices.com/software/oss/sussen/"
SRC_URI="http://www.lbtechservices.com/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
IUSE="doc gnome"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-lang/mono
	gnome? ( >=dev-dotnet/gtk-sharp-2.4
			 >=dev-dotnet/gnome-sharp-2.4
			 >=dev-dotnet/gconf-sharp-2.4
			 >=dev-dotnet/glade-sharp-2.4
			 || ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 ) )"

DEPEND="${RDEPEND}
	doc? ( virtual/monodoc )
	virtual/pkgconfig
	app-arch/rpm
	>=dev-util/intltool-0.34.2"

DOCS="AUTHORS ChangeLog README TODO NEWS"

pkg_setup() {
	use gnome || elog "gnome is absent in USE thus applet and editor will not be built"
}

# src_unpack, pkg_postinst, pkg_postrm are exported in gnome2.eclass. But since
# we have gnome2 support depends on USE let's call gnome2.eclass internal
# functions only when USE="gnome".
src_prepare() {
	use gnome && gnome2_omf_fix
	# Put all asp pages in /usr/share/$PF dir instead of /usr/share/sussen

	sed -i -e \
	"s:wwwdir = \$(datadir)/doc/sussen/www/asp:wwwdir = \$(datadir)/doc/${PF}/www/asp:" \
	www/asp/Makefile.in || die "sed failed."
}

src_configure() {
	# $(use_enable web yes)
	econf ${myconf} \
		--enable-web=no \
		$(use_enable gnome)
}

src_compile() {
	emake -j1 || die "Compilation failed"
}

src_install () {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ${DOCS}

	if use gnome ; then
		ewarn "sussen-editor is removed from package. It'll became available"
		ewarn "in the 1.1/1.2 branch."
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
