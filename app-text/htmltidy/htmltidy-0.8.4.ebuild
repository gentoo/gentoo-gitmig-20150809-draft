# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/htmltidy/htmltidy-0.8.4.ebuild,v 1.6 2002/08/16 02:42:01 murphy Exp $

# convert from normalized gentoo version number to htmltidy's wacky date thing
month=(dmy jan feb mar apr may jun jul aug sep oct nov dec)
parts=(${PV//./ })
vers=$(printf "%d%s%02d" ${parts[2]} ${month[${parts[1]}]} ${parts[0]})
MY_P=tidy${vers}
S=${WORKDIR}/${MY_P}

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"

DESCRIPTION="fix mistakes and tidy up sloppy editing in HTML and XML"
SRC_URI="mirror://sourceforge/tidy/${MY_P}.tgz"
HOMEPAGE="http://tidy.sourceforge.net/"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix man page install path and skip "chown"
	t=Makefile
	cp $t $t.orig
	sed 's:)man/:)share/man/:; s:chgrp\|chown:#&:' $t.orig > $t
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	mkdir -p "${D}/usr/bin"
	mkdir -p "${D}/usr/share/man/man1"
	make INSTALLDIR="${D}/usr/" install || die
	dohtml -a html,gif *
}
