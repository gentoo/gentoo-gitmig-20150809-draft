# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/globespan-adsl/globespan-adsl-0.10.ebuild,v 1.8 2007/05/02 07:54:52 genone Exp $

inherit fixheadtails

MY_PN="eciadsl-usermode-${PV}"

DESCRIPTION="Driver for various ADSL modems. Also known as EciAdsl."
SRC_URI="http://eciadsl.flashtux.org/download/${MY_PN}.tar.gz"
HOMEPAGE="http://eciadsl.flashtux.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="tk"

DEPEND="net-dialup/ppp"
RDEPEND="${DEPEND}
	tk? ( >=dev-lang/tk-8.3.4 )"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A} || die "failed to unpack"
	cd "${S}" || die "source directory not found"
	ht_fix_all

	einfo "Correct obsolete nice parameters"
	sed -i -e 's:nice --:nice -n -:' eciadsl-{start,stop,doctor} || \
		die "failed to replace nice params"
}

src_compile() {
	BIN_DIR="/usr/bin" ./configure --prefix=/usr --conf-prefix=/etc \
	 --conf-dir=/eciadsl  --doc-prefix=/usr/share/doc --doc-dir=/eciads --disable-pppd-check\
	 || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make ROOT="${D}" install || die "Install failed"
}

pkg_postinst() {
	elog
	elog "Package succesfully installed you should now run "
	elog "eciconf.sh (graphical, requires TCL/TK) or eciconftxt.sh"
	elog
	elog "Paquetage installé avec succés vous devriez maintenant"
	elog "executer eciconf.sh (qui requiert TCL/TK) ou eciconftxt.sh"
	elog
	ewarn "Please note that if you're using a 2.6.x kernel you'll"
	ewarn "probably need to apply a patch to fix a USB bug. See"
	ewarn "http://eciadsl.flashtux.org/download/beta/"
	ewarn
}
