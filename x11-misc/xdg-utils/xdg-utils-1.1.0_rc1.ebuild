# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-utils/xdg-utils-1.1.0_rc1.ebuild,v 1.1 2011/01/21 16:21:07 ssuominen Exp $

EAPI=3

MY_P=${P/_/-}

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/"
SRC_URI="http://portland.freedesktop.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="x11-apps/xprop
	x11-apps/xset
	x11-misc/shared-mime-info"
PDEPEND="dev-util/desktop-file-utils"

RESTRICT="test" # root access required

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README RELEASE_NOTES TODO || die
	newdoc scripts/README README.scripts || die

	if use doc; then
		dohtml -r scripts/html || die
	fi

	# Install default XDG_DATA_DIRS, bug #264647
	echo 'XDG_DATA_DIRS="/usr/local/share"' > 30xdg-data-local
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local
	doenvd 30xdg-data-local || die

	echo 'XDG_DATA_DIRS="/usr/share"' > 90xdg-data-base
	echo 'XDG_CONFIG_DIRS="/etc/xdg"' >> 90xdg-data-base
	doenvd 90xdg-data-base || die
}

pkg_postinst() {
	if ! has_version "x11-libs/gtk+:2"; then
		echo
		elog "Install x11-libs/gtk+:2 if you need the gtk-update-icon-cache command."
		echo
	fi
}
