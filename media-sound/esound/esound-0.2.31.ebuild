# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.31.ebuild,v 1.1 2003/08/11 21:53:52 foser Exp $

IUSE="tcpd alsa ipv6"

inherit libtool gnome.org

DESCRIPTION="The Enlightened Sound Daemon"

HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~hppa ~amd64"

DEPEND=">=media-libs/audiofile-0.1.5
	alsa? ( >=media-libs/alsa-lib-0.5.10b )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

src_compile() {
	elibtoolize

	local myconf=""
	use tcpd && myconf="${myconf} --with-libwrap" \
		|| myconf="${myconf} --without-libwrap"

	use alsa && myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --enable-alsa=no"

	econf \
		--sysconfdir=/etc/esd \
		`use_enable ipv6` \
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
