# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/xulrunner-bin/xulrunner-bin-1.8.1.19.ebuild,v 1.2 2008/12/20 21:17:19 maekke Exp $

inherit eutils multilib mozilla-launcher

DESCRIPTION="Mozilla runtime package that can be used to bootstrap XUL+XPCOM applications"
HOMEPAGE="http://developer.mozilla.org/en/docs/XULRunner"
SRC_URI="mirror://gentoo/${P}.tbz2
	http://dev.gentoo.org/~armin76/dist/${P}.tbz2"
RESTRICT="strip"

KEYWORDS="-* amd64 x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE=""

DEPEND=""
RDEPEND="x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	x86? (
		>=x11-libs/gtk+-2.2
	)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-compat
	)"

S="${WORKDIR}/usr/lib/xulrunner/"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/opt/xulrunner"

	# Install firefox in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

	# Create /usr/bin/xulrunner-bin
	install_mozilla_launcher_stub xulrunner-bin ${MOZILLA_FIVE_HOME}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10xulrunner-bin

	# install ldpath env.d
	doenvd "${FILESDIR}"/71xulrunner-bin

	insinto /etc/gre.d
	newins "${FILESDIR}"/${PN}.conf ${PV}-bin.conf
	sed -i -e \
		"s|version|${PV}|
				s|instpath|${MOZILLA_FIVE_HOME}|" \
					"${D}"/etc/gre.d/${PV}-bin.conf
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/opt/xulrunner"

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${ROOT}"${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	use amd64 && einfo "NB: You just installed a 32-bit xulrunner"
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
