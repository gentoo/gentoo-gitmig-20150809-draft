# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.50.10.ebuild,v 1.3 2003/05/11 02:29:44 jrray Exp $

IUSE="cdr gnome"

inherit perl-module

MY_P=${P/dvdr/Video-DVDR}
# Next three lines are to handle PRE versions
MY_P=${MY_P/_pre/_}
MY_URL="dist"
[ "${P/pre}" != "${P}" ] && MY_URL="dist/pre"

S=${WORKDIR}/${MY_P}
DESCRIPTION="dvd::rip is a graphical frontend for transcode"
SRC_URI="http://www.exit1.org/${PN}/${MY_URL}/${MY_P}.tar.gz"
HOMEPAGE="http://www.exit1.org/dvdrip/"
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~x86"

DEPEND=" gnome? ( gnome-extra/gtkhtml )
	cdr? ( >=media-video/vcdimager-0.7.12
		>=app-cdr/cdrdao-1.1.7
		>=app-cdr/cdrtools-2.0 )
	>=media-video/transcode-0.6.3
	>=media-gfx/imagemagick-5.5.3
	sys-apps/procps
	dev-perl/gtk-perl
	dev-perl/Storable
	dev-perl/Event"

RDEPEND=">=net-analyzer/fping-2.3
		>=media-sound/ogmtools-0.972
		>=media-video/mjpegtools-1.6.0
		sys-apps/eject"

src_install () {
	perl-module_src_install
}

pkg_postinst () {
	einfo "If you want to use the cluster-mode, you need to SUID fping"
	einfo "chmod u+s /usr/sbin/fping"
	einfo
	einfo "for Perl 5.8.x you have to set PERLIO to read TOC properly"
	einfo "for bash: export PERLIO=stdio"
	einfo "for csh:  setenv PERLIO stdio"
	einfo "into your /.${shell}rc"
}
