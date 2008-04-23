# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geneweb/geneweb-5.01-r1.ebuild,v 1.1 2008/04/23 15:58:06 tupone Exp $

inherit eutils

EAPI="1"

DESCRIPTION="Genealogy software program with a Web interface."
HOMEPAGE="http://cristal.inria.fr/~ddr/GeneWeb/"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/cristal/${PN}/Src/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DEPEND="dev-lang/ocaml
	dev-ml/camlp5"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt
	then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:/usr/share/${PN}:" \
		setup/setup.ml || die "Failed sed for gentoo path"
	rm -f contrib/gwdiff/.*
}

src_compile() {
	econf
	if use ocamlopt; then
		emake || die "Compiling native code executables failed"
	else
		emake OCAMLC=ocamlc OCAMLOPT=ocamlopt out \
			|| die "Compiling byte code executables failed"
		# If using bytecode we dont want to strip the binary as it would remove
		# the bytecode and only leave ocamlrun...
		export STRIP_MASK="*/bin/*"
	fi
}

src_install() {
	make distrib || die "Failed making distrib"
	cd distribution/gw
	# Install doc
	dodoc CHANGES.txt
	# Install binaries
	dobin gwc gwc2 consang gwd gwu update_nldb ged2gwb gwb2ged gwsetup \
		|| die "Failed installing binaries"
	insinto /usr/lib/${PN}
	doins -r gwtp_tmp/* || die "Failed installing CGI program"
	dodoc a.gwf
	dohtml -r doc/*
	insinto /usr/share/${PN}
	doins -r etc images lang setup gwd.arg only.txt\
		|| die "Failed installing data"

	cd ../..

	# Install binaries
	dobin src/check_base \
		|| die "Failed installing check_base binaries"
	# Install manpages
	doman man/* || die "Failed installing man pages"

	# Install doc
	dodoc ICHANGES
	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/{gwdiff,misc,templ} \
		|| die "Failed installing contributions"

	newinitd "${FILESDIR}/geneweb.initd" geneweb
	newconfd "${FILESDIR}/geneweb.confd" geneweb
}

pkg_postinst() {
	enewuser geneweb "" "/bin/bash" /var/lib/geneweb
	einfo "A CGI program has been installed in /usr/lib/${PN}. Follow the"
	einfo "instructions on the README in that directory to use it"
}
