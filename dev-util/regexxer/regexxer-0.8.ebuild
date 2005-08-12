# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/regexxer/regexxer-0.8.ebuild,v 1.3 2005/08/12 20:27:57 metalgod Exp $

DESCRIPTION="An interactive tool for performing search and replace operations"
HOMEPAGE="http://regexxer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

#inherit gnome2

LICENSE="GPL-2"
IUSE="gnome"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-cpp/libglademm-2.4.0
	>=dev-libs/libsigc++-2.0
	>=dev-cpp/gtkmm-2.4.0
	>=dev-libs/libpcre-4.0
	>=dev-cpp/gconfmm-2.6.1"


DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	echo $GCONF_CONFIG_SOURCE
	econf || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	einstall || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	# More or less copied from gnome2_gconf_install, which didn't work here
	export GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
	einfo "Installing GNOME 2 GConf schemas"
	${ROOT}/usr/bin/gconftool-2 --makefile-install-rule ${S}/regexxer.schemas 1>/dev/null
	if use gnome ; then
		insinto /usr/share/gnome/apps/Development
		doins ${S}/regexxer.desktop
	fi
}
