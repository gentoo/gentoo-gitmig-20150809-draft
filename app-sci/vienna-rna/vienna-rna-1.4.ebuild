# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/vienna-rna/vienna-rna-1.4.ebuild,v 1.4 2004/11/01 03:03:35 ribosome Exp $

inherit flag-o-matic

DESCRIPTION="Vienna RNA Package - RNA secondary structure prediction and comparison"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA/"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-${PV}.tar.gz"
LICENSE="vienna-rna"

SLOT=0
KEYWORDS="x86 ~ppc"
IUSE="no-utils no-readseq perl"

DEPEND="perl? ( dev-lang/perl )
	!no-utils? ( dev-lang/perl )"

S="${WORKDIR}/ViennaRNA-${PV}"

src_compile() {
	sed -ie 's:/usr/local/bin/perl:/usr/bin/perl:' Perl/RNAfold.pl
	sed -ie 's:/usr/local/bin/perl:/usr/bin/perl:' Utils/ct2b.pl
	sed -ie 's:/usr/local/bin/perl:/usr/bin/perl:' Utils/b2mt.pl
	sed -ie 's:/usr/local/bin/perl:/usr/bin/perl:' Utils/dpzoom.pl
	sed -ie 's:/usr/local/bin/perl:/usr/bin/perl:' Utils/mountain.pl
	append-flags -I../H
	make -e library programs gammel subopt || die
	use perl && make -e perl || die
	use no-utils || make -e util || die
	use no-readseq || cd Readseq && make -e || die
}

src_install() {
	insinto /usr/include/vienna-rna
	doins H/*
	dolib.a lib/libRNA.a
	dobin Cluster/{AnalyseDists,AnalyseSeqs}
	dobin Progs/RNA{distance,eval,fold,heat,inverse,pdist}
	dobin Subopt/{RNAsubopt,popt}

	dodoc CHANGES CREDITS README
	doinfo man/RNAlib.info
	newman man/AnalyseDists.man AnalyseDists.man.1
	newman man/AnalyseSeqs.man AnalyseSeqs.man.1
	newman man/RNAdistance.man RNAdistance.man.1
	newman man/RNAeval.man RNAeval.man.1
	newman man/RNAfold.man RNAfold.man.1
	newman man/RNAheat.man RNAheat.man.1
	newman man/RNAinverse.man RNAinverse.man.1
	newman man/RNApdist.man RNApdist.man.1
	newman Subopt/RNAsubopt.man RNAsubopt.man.1
	dohtml man/RNAlib.html
	insinto /usr/share/doc/${P}/pdf
	doins man/RNAlib.pdf

	if use perl; then
		cd Perl
		make install DESTDIR=${D} || die
		dodoc RNA_wrap.doc
		cd ${S}
	fi

	if ! use no-utils; then
		dobin Utils/{b2ct,ct2b.pl,dpzoom.pl,mountain.pl,b2mt.pl,Fold,RNAplot}
		newdoc Utils/README README.utils
		newman Utils/RNAplot.man RNAplot.man.1
	fi

	if ! use no-readseq; then
		newbin Readseq/readseq readseq-vienna
		newdoc Readseq/Readme README.readseq
		newdoc Readseq/Formats FORMATS.readseq
		newdoc Readseq/README README.readseq-vienna
	fi
}
