# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.29-r1.ebuild,v 1.3 2003/05/30 22:55:56 utx Exp $

IUSE="tcpd alsa"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="The Enlightened Sound Daemon"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2" 

HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND=" >=media-libs/audiofile-0.1.9
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/esound-0.2.29-alsa-period.diff
}

src_compile() {
	elibtoolize

	local myconf=""
	use tcpd && myconf="${myconf} --with-libwrap" \
		|| myconf="${myconf} --without-libwrap"

	use alsa && myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --enable-alsa=no"

	econf \
		--sysconfdir=/etc/esd \
		${myconf} || die

	make || die
}

src_install() {                               
	einstall \
		sysconfdir=${D}/etc/esd \
		|| die

	dodoc AUTHORS COPYING* ChangeLog README TODO NEWS TIPS
	dodoc docs/esound.ps

	dohtml -r docs/html

	insinto /etc/conf.d
	newins ${FILESDIR}/esound.conf.d esound

        exeinto /etc/init.d
	extradepend=""
	use tcpd && extradepend=" portmap"
	use alsa && extradepend="$extradepend alsasound"
        sed "s/@extradepend@/$extradepend/" <${FILESDIR}/esound.init.d >${T}/esound
	doexe ${T}/esound

}

pkg_postinst() {
        # rebuild init deps to include deps on esound
        /etc/init.d/depscan.sh
}

pkg_postrm() {
        # rebuild init deps to remove deps on esound
        /etc/init.d/depscan.sh
}
