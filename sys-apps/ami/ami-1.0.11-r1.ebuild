# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jays Kwak <jayskwak@gentoo.or.kr>
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/ami/ami-1.0.11-r1.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S=${WORKDIR}/${P}
DESCRIPTION="Korean IMS Ami"
SRC_URI="http://www.kr.freebsd.org/~hwang/ami/${P}.tar.gz
    http://www.kr.freebsd.org/~hwang/ami/hanja.dic.gz
	ftp://ftp.nnongae.com/pub/gentoo/${P}.patch"
HOMEPAGE="http://www.kr.freebsd.org/~hwang/ami/index.html"

DEPEND=">=media-libs/gdk-pixbuf-0.7.0"

src_unpack() {
    unpack ${P}.tar.gz

	patch -p0 < ${DISTDIR}/${P}.patch || die
}

src_compile() {
    local config

    use gnome && config="--enable-gnome-applet"

    ./configure \
        --host=${CHOST} \
        --prefix=/usr \
        --infodir=/usr/share/info \
        --with-hangul-keyboard=2 \
        --sysconfdir=/etc \
        ${config} \
        --mandir=/usr/share/man || die "./configure failed"

    emake || die

    cd ${S}/hanjadic
    emake || die
}

src_install () {

    make \
        prefix=${D}/usr \
        mandir=${D}/usr/share/man \
        infodir=${D}/usr/share/info \
        sysconfdir=${D}/etc \
        install || die

    gzip -d -c ${DISTDIR}/hanja.dic.gz > ${D}/usr/share/ami/hanja.dic

    dobin ${S}/hanjadic/hanja-hwp2ami
    dodoc AUTHORS COPYING* ChangeLog INSTALL README README.en NEWS THANKS
}
