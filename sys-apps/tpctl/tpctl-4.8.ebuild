# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tpctl/tpctl-4.8.ebuild,v 1.1 2003/12/25 10:35:49 robbat2 Exp $

IUSE="ncurses tpctlir perl"

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"

DESCRIPTION="Thinkpad system control user space programs"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
KEYWORDS="~x86 amd64 -ppc -mips -sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-apps/thinkpad-4.8 ncurses? ( sys-libs/ncurses )"
RDEPEND=">=sys-apps/thinkpad-4.8 ncurses? ( sys-libs/ncurses )
	perl? ( dev-lang/perl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/tpctlir-cli-4.4-r1.diff
}

src_compile() {

	emake -C lib || die "lib make failed"
	emake -C tpctl || die "tpctl make failed"
	if use ncurses; then
		emake -C ntpctl || die "ntpctl make failed"
	fi

	# Only for thinkpad models 760 and 765
	# build with:
	# $ USE=tpctlir emerge tpctl
	if use tpctlir; then
		emake -C tpctlir || die "tpctlir make failed"
	fi
}

src_install() {
	dodoc AUTHORS COPYING ChangeLog README SUPPORTED-MODELS TROUBLESHOOTING \
		VGA-MODES
	dolib lib/libsmapidev.so.2.0
	dobin tpctl/tpctl
	[ -e ntpctl/ntpctl ] && dobin ntpctl/ntpctl
	if use tpctlir && [ -e tpctlir/tpctlir ]; then
		mv tpctlir/README README.tpctlir
		dodoc README.tpctlir
		dobin tpctlir/tpctlir
	fi
	if use perl; then
		mv apmiser/README README.apmiser
		dodoc README.apmiser
		dosbin apmiser/apmiser
		exeinto /etc/init.d
		newexe ${FILESDIR}/apmiser.rc apmiser
	fi
	doman man/{ntpctl,tpctl}.1 man/apmiser.8
}
