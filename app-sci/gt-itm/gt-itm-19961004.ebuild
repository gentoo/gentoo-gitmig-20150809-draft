# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gt-itm/gt-itm-19961004.ebuild,v 1.1 2004/01/11 09:16:40 robbat2 Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.cc.gatech.edu/fac/Ellen.Zegura/graphs.html
		  http://www.isi.edu/nsnam/ns/ns-topogen.html#gt-itm"
SRC_URI="http://www.cc.gatech.edu/fac/Ellen.Zegura/gt-itm/gt-itm.tar.gz
		 http://www.isi.edu/nsnam/dist/sgb2ns.tar.gz"
LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-util/sgb"
S=${WORKDIR}/${PN}
S2=${WORKDIR}/sgb2ns

src_unpack() {
	unpack sgb2ns.tar.gz

	mkdir ${S}
	cd ${S}
	unpack gt-itm.tar.gz

	sed -r -e '/^[[:alnum:]]+\.o:/d' -e 's|LIBS = -lm -lgb.*|LIBS = -lm -lgb|' -i ${S}/src/Makefile
	sed -r -e '/^SYS = -DSYSV/d' -e 's|LIBS = -lm -lgb.*|LIBS = -lm -lgb|' -i ${S2}/Makefile  || die

	rm -f ${S}/lib/*

	find ${S}/sample-graphs/ -perm +111 -type f -name 'Run*' \
	| xargs -r -n1 sed -re 's|(\.\./)+bin/||g' -i || die

	sed -e 's|sys/types.h|sys/param.h|' -i ${S}/src/geog.c
	sed -e '162 s/connected $/connected \\/' -i ${S}/src/eval.c
}

src_compile() {
	cd ${S}/src
	emake CFLAGS="${CFLAGS} -I../include" || die

	cd ${S2}
	emake CFLAGS="${CFLAGS} -I\$(IDIR) -L\$(LDIR)" || die
}

src_install() {
	dobin ${S}/bin/*
	dodoc ${S}/README ${S}/docs/*
	cp -ra ${S}/sample-graphs ${D}/usr/share/doc/${PF}

	cd ${S2}
	dodoc *.tcl *.gb
	newdoc README README.sgb2ns

}
