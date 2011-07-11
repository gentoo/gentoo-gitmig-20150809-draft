# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-utils/xdg-utils-1.1.0_rc1_p20110519.ebuild,v 1.3 2011/07/11 13:21:05 ssuominen Exp $

EAPI=4

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://portland.freedesktop.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="dev-util/desktop-file-utils
	dev-perl/File-MimeInfo
	x11-misc/shared-mime-info
	x11-apps/xprop
	x11-apps/xset"
DEPEND=""

DOCS=( ChangeLog README RELEASE_NOTES TODO )

src_test() { :; } # write access as root outside of sandbox required

src_install() {
	default

	newdoc scripts/README README.scripts

	if use doc; then
		dohtml -r scripts/html
	fi

	# Install default XDG_DATA_DIRS, bug #264647
	echo 'XDG_DATA_DIRS="/usr/local/share"' > 30xdg-data-local
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local
	doenvd 30xdg-data-local

	echo 'XDG_DATA_DIRS="/usr/share"' > 90xdg-data-base
	echo 'XDG_CONFIG_DIRS="/etc/xdg"' >> 90xdg-data-base
	doenvd 90xdg-data-base
}

pkg_postinst() {
	[[ -x $(type -P gtk-update-icon-cache) ]] || elog "Install x11-libs/gtk+:2 for the gtk-update-icon-cache command."
}
