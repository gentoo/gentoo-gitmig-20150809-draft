# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/glimmerhmm/glimmerhmm-3.0.1.ebuild,v 1.6 2011/06/20 08:32:26 jlec Exp $

inherit toolchain-funcs

MY_P=GlimmerHMM

DESCRIPTION="An eukaryotic gene finding system from TIGR"
HOMEPAGE="http://www.cbcb.umd.edu/software/GlimmerHMM/"
SRC_URI="ftp://ftp.cbcb.umd.edu/pub/software/glimmerhmm/${MY_P}-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

src_unpack() {
	unpack ${A}
	mv GlimmerHMM ${P}
	sed \
		-e 's|\(my $scriptdir=\)$FindBin::Bin|\1"/usr/share/'${PN}'/training_utils"|' \
		-e 's|\(use lib\) $FindBin::Bin|\1 "/usr/share/'${PN}'/lib"|' \
		-i "${S}/train/trainGlimmerHMM" || die
	sed \
		-e 's/^CFLAGS[ ]*=.*//' \
		-e 's/C *=.*/C='$(tc-getCC)'/' \
		-e 's/CC *=.*/CC='$(tc-getCXX)'/' \
		-i "${S}"/*/makefile || die
}

src_compile() {
	emake -C "${S}/sources" || die "emake failed in sources"
	emake -C "${S}/train" || die "emake failed in train"
}

src_install() {
	dobin sources/glimmerhmm train/trainGlimmerHMM || die

	insinto /usr/share/${PN}/lib
	doins train/*.pm || die
	insinto /usr/share/${PN}/models
	doins -r trained_dir/* || die
	exeinto /usr/share/${PN}/training_utils
	doexe train/{build{1,2,-icm,-icm-noframe},erfapp,falsecomp,findsites,karlin,score,score{2,ATG,ATG2,STOP,STOP2},splicescore} || die

	dodoc README.first train/readme.train
}
