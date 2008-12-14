# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.35.ebuild,v 1.7 2008/12/14 13:33:35 loki_val Exp $

#WANT_AUTOCONF="latest"
#WANT_AUTOMAKE="1.8"
#inherit eutils gnome2 mono autotools

inherit gnome2 mono eutils

DESCRIPTION="Sussen is a tool that checks for vulnerabilities and configuration issues on computer systems"
HOMEPAGE="http://dev.mmgsecurity.com/projects/sussen/"
SRC_URI="http://dev.mmgsecurity.com/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="doc gnome"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

RDEPEND="dev-lang/mono
	gnome? ( >=dev-dotnet/gtk-sharp-2.4
			 >=dev-dotnet/gnome-sharp-2.4
			 >=dev-dotnet/gconf-sharp-2.4
			 || ( >=dev-dotnet/gtk-sharp-2.12.6 >=dev-dotnet/glade-sharp-2.4 )
			 gnome-base/gnome-panel )"

DEPEND="${RDEPEND}
	doc? (
		|| (
		 >=dev-lang/mono-2.2_pre1
		 >=dev-util/monodoc-1.1.8
		)
	)
	dev-util/pkgconfig
	app-arch/rpm
	>=dev-util/intltool-0.34.2"

DOCS="AUTHORS ChangeLog README TODO"

pkg_setup() {
	if has_version '>=dev-dotnet/gtk-sharp-2.12.6'
	then
		if ! built_with_use --missing false 'dev-dotnet/gtk-sharp' 'glade'
		then
			eerror "Please rebuild >=dev-dotnet/gtk-sharp-2.12.6 with USE='glade'"
		fi
	fi
	use gnome || elog "gnome is absent in USE thus applet and editor will not be built"
}

# src_unpack, pkg_postinst, pkg_postrm are exported in gnome2.eclass. But since
# we have gnome2 support depends on USE let's call gnome2.eclass internal
# functions only when USE="gnome".
src_unpack() {
	unpack ${A}
	cd "${S}"

	use gnome && gnome2_omf_fix
}

src_compile () {
	# Put all asp pages in /usr/share/$PF dir instead of /usr/share/sussen
	sed -i -e \
	"s:wwwdir = \$(datadir)/doc/sussen/www/asp:wwwdir = \$(datadir)/doc/${PF}/www/asp:" \
	www/asp/Makefile.in || die "sed failed."

	# $(use_enable web yes)
	econf ${myconf} \
		--enable-web=no \
		$(use_enable gnome) || die "./configure failed."

	emake -j1 || die "Compilation failed"
}

src_install () {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ${DOCS}

	if use gnome ; then
		ewarn "sussen-editor is still work in progress... But 'new', 'save' and"
		ewarn "'save as' operations are now implemented. Also it is possible to"
		ewarn "execute definitions."
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
