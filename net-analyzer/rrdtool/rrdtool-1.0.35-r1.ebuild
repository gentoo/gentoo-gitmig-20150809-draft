# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.0.35-r1.ebuild,v 1.1 2002/04/15 11:57:29 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A system to store and display time-series data"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/rrdtool/pub/${P}.tar.gz"
HOMEPAGE="http://ee-staff.ethz.ca/~oetiker/webtools/rrdtool/"

RDEPEND="sys-devel/perl
	tcltk? ( dev-lang/tcl )"

DEPEND="${RDEPEND}
		>=media-libs/libgd-1.8.3"

src_compile() {

	local myconf
	use tcltk \
		&& myconf="--with-tcllib=/usr/lib" \
		|| myconf="--without-tcllib"

	./configure \
		--prefix=/opt/rrdtool \
		--mandir=/usr/share/man \
		--with-perl-options='INSTALLMAN1DIR=${D}/usr/share/man/man1 INSTALLMAN3DIR=${D}/usr/share/man/man3' \
		${myconf} || die

	make || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	make \
		PREFIX=${D}/usr \
		site-perl-install || die
}
