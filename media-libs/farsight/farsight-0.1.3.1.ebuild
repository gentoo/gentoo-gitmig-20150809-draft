# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/farsight/farsight-0.1.3.1.ebuild,v 1.1 2006/06/09 23:28:59 genstef Exp $

DESCRIPTION="FarSight is an audio/video conferencing framework specifically designed for Instant Messengers."
HOMEPAGE="http://farsight.sourceforge.net/"
SRC_URI="http://extindt01.indt.org/VoIP/${P}.tar.gz"
#EDARCS_REPO_URI="http://projects.collabora.co.uk/darcs/farsight/farsight"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="sofia-sip gnet jingle"
# msn yahoo
SLOT="0"

RDEPEND="=media-libs/gstreamer-0.10*
	=media-plugins/gst-plugins-farsight-0.10*
	>=dev-libs/glib-2.0
	dev-libs/libxml2
	gnet? ( net-libs/gnet )
	sofia-sip? ( net-libs/sofia-sip )
	jingle? ( net-libs/libjingle )"

src_compile() {
	NOCONFIGURE=1 ./autogen.sh

	econf --disable-debug \
		--disable-gtk-doc \
		--disable-sequence-diagrams \
		--disable-msnwebcam \
		--disable-msnavconf \
		--disable-yahoowebcam \
		--enable-rtp \
		$(use_enable sofia-sip) \
		$(use_enable gnet) \
		$(use_enable jingle jingle-p2p) || die "econf failed"
	# Does not compile currently
	# $(use_enable msn msnwebcam) \
	# $(use_enable msn msnavconf) \
	# $(use_enable yahoo yahoowebcam) \
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
