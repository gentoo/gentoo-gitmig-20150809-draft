# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/hellanzb/hellanzb-0.13-r1.ebuild,v 1.1 2007/04/05 18:35:25 aballier Exp $

inherit distutils eutils

DESCRIPTION="Retrieves and processes .nzb files"
HOMEPAGE="http://www.hellanzb.com/"
SRC_URI="http://www.hellanzb.com/distfiles/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="libnotify"

RDEPEND=">=dev-python/twisted-2.0
		dev-python/twisted-web
		|| ( app-arch/unrar
			 app-arch/rar )
		app-arch/par2cmdline
		libnotify? ( dev-python/notify-python )"

DEPEND=""

DOCS="CHANGELOG CREDITS PKG-INFO README"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-datafiles.patch"
}

src_install() {
	distutils_src_install

	newconfd "${FILESDIR}/hellanzb.conf" hellanzb
	newinitd "${FILESDIR}/hellanzb.init" hellanzb

	insinto etc
	doins etc/hellanzb.conf.sample
}

pkg_postinst() {
	elog "You can start hellanzb in the background automatically by using"
	elog "the init-script. To do this, add it to your default runlevel:"
	elog ""
	elog "    rc-update add hellanzb default"
	elog ""
	elog "Use this command to start the daemon now:"
	elog ""
	elog "    /etc/init.d/hellanzb start"
	elog ""
	elog "You will have to config /etc/conf.d/hellanzb before the init-script"
	elog "will work. It is recommended that you change the user under which"
	elog "the daemon will run."
}
