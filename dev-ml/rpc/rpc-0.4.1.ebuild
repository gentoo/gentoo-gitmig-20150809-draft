# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/rpc/rpc-0.4.1.ebuild,v 1.1 2005/03/27 15:30:56 mattam Exp $

inherit findlib

DESCRIPTION="OCaml implementation of Sun's protocol for Remote Procedure Calls"
HOMEPAGE="http://www.ocaml-programming.de/programming/rpc.html"
LICENSE="as-is"
DEPEND=">=dev-lang/ocaml-3.08
	dev-ml/equeue
	>=dev-ml/ocamlnet-0.95
	>=dev-ml/netclient-0.90"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
# Stripping breaks ocamlrpcgen
RESTRICT="nostrip"

# TODO: add optional AUTH support
# - add "auth" to IUSE
# - "$(use_with auth auth-local)" + "$(use_with auth auth-dh)" for ./configure
# - "use auth && dodoc doc/README.authdh" for src_install()
# But that's still a bit experimental, and i have no way to test it.

src_compile() {
	./configure -with-ocamlrpcgen || die "Configuration failed"
	make all opt || die "Compilation failed"
}

src_install () {
	dodir /usr/bin
	findlib_src_install BINDIR=${D}/usr/bin/
	dodoc doc/{README,LICENSE,INSTALL}
	if use doc; then
		for dir in examples/*
		do
		  if [ -d $dir ]
			  then
			  insinto /usr/share/doc/${PF}/$dir
			  doins $dir/*
		  else
			  insinto /usr/share/doc/${PF}/examples
			  doins $dir
		  fi
		done
		insinto /usr/share/doc/${PF}/examples
		doins doc/*.ml*
	fi
	# Thanks to Thomas Petazzoni for this manpage, it's from his Debian package
	doman ${FILESDIR}/ocamlrpcgen.1
}
