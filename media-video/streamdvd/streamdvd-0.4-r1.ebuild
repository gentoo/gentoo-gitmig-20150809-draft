# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/streamdvd/streamdvd-0.4-r1.ebuild,v 1.2 2004/07/27 00:00:21 mr_bones_ Exp $

DESCRIPTION="fast tool to backup Video DVDs 'on the fly'"
HOMEPAGE="http://www.badabum.de/streamdvd.html"
SRC_URI="http://www.badabum.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gui"

DEPEND="media-libs/libdvdread
	gui? ( dev-perl/perl-tk
	app-cdr/cdrtools
	>=media-video/dvdauthor-0.6.5
	>=app-cdr/dvd+rw-tools-5.13.4.7.4 )"

S="${WORKDIR}/StreamDVD-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	sed -i "s: -g -Wall : ${CFLAGS} :" Makefile
	use gui && epatch "${FILESDIR}/${P}.patch"
}

src_compile() {
	emake all addon || die  # compile also optional packages
}

src_install() {
	dobin streamdvd streamanalyze
	newbin lsdvd lsdvd-streamdvd  # patched lsdvd, rename to avoid conflict with media-video/lsdvd
	dodoc COPYING README
	newdoc contrib/lsdvd/AUTHORS AUTHORS.lsdvd
	newdoc contrib/lsdvd/README README.lsdvd
	newdoc contrib/StreamAnalyze/README README.streamanalyze
	if use gui
	then
		eval `perl '-V:installvendorlib'`
		insinto "$installvendorlib/StreamDVD"
		doins Gui/StreamDVD/*.pm
		dobin Gui/StreamDVD.pl
		dosym StreamDVD.pl /usr/bin/streamdvd_gui  # convinience symlink
		newdoc Gui/README README.gui
	fi
}

