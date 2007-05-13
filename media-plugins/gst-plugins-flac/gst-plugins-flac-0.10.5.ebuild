# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.5.ebuild,v 1.3 2007/05/13 09:44:07 aballier Exp $

WANT_AUTOCONF=2.5

inherit gst-plugins-good eutils autotools

SRC_URI="${SRC_URI} mirror://gentoo/${P}-flac-1.1.3.patch.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.2
	>=media-libs/gstreamer-0.10.10
	>=media-libs/gst-plugins-base-0.10.10.1"
DEPEND="${RDEPEND}"

src_unpack() {
	gst-plugins-good_src_unpack

	epatch "${WORKDIR}/${P}-flac-1.1.3.patch"
	eautoconf
}
