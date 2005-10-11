# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-0.99.99.ebuild,v 1.13 2005/10/11 22:05:44 wolf31o2 Exp $

DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://fedora.redhat.com/projects/additional-projects/kudzu/"

KEYWORDS="alpha amd64 -mips -ppc -sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/newt"
DEPEND="$RDEPEND
	sys-devel/gettext
	sys-apps/pciutils
	>=dev-libs/dietlibc-0.20
	!sys-libx/libkudzu
	!sys-libs/libkudzu-knoppix
	!sys-apps/kudzu-knoppix"

src_compile() {
	emake  || die

	if use x86
	then
		cd ddcprobe || die
		emake || die
	fi
}

src_install() {
	einstall install-program DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man \
		|| die "Install failed"

	# Init script isn't appropriate
	rm -rf ${D}/etc/rc.d

	# Add our own init scripts
	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
	newconfd ${FILESDIR}/${PN}.conf.d ${PN} || die

	if use x86
	then
		cd ${S}/ddcprobe || die
		dosbin svgamodes modetest ddcxinfo ddcprobe || die
	fi
}

