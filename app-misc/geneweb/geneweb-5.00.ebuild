# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geneweb/geneweb-5.00.ebuild,v 1.2 2007/08/26 20:01:16 tupone Exp $

inherit eutils

DESCRIPTION="Genealogy software program with a Web interface."
HOMEPAGE="http://cristal.inria.fr/~ddr/GeneWeb/"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/cristal/${PN}/Src/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ocaml"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:/usr/share/${PN}:" \
		setup/setup.ml || die "Failed sed for gentoo path"
}

src_install() {
	# Install binaries
	dobin src/{consang,check_base,gwc,gwd,gwu} \
		ged2gwb/ged2gwb gwb2ged/gwb2ged setup/gwsetup \
		|| die "Failed installing binaries"
	# Install manpages
	doman man/* || die "Failed installing man pages"

	# Install doc
	dodoc ICHANGES etc/LISEZMOI.distrib.txt etc/README.distrib.txt \
		CHANGES etc/a.gwf etc/LISEZMOI.distrib.txt README.distrib.txt
	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/{misc,templ} || die "Failed installing contributions"

	make distrib || die "Failed making distrib"
	insinto /usr/share/${PN}
	doins -r distribution/gw/{doc,etc,gwd.arg,images,lang,only.txt,setup} \
		|| die "Failed installing data"
	insinto /usr/lib/${PN}
	doins -r distribution/gw/gwtp_tmp/* || die "Failed installing CGI program"

	newinitd "${FILESDIR}/geneweb.initd" geneweb
	newconfd "${FILESDIR}/geneweb.confd" geneweb
}

pkg_postinst() {
	enewuser geneweb "" "/bin/bash" /var/lib/geneweb
	einfo "A CGI program has been installed in /usr/lib/${PN}. Follow the"
	einfo "instructions on the README in that directory to use it"
}
