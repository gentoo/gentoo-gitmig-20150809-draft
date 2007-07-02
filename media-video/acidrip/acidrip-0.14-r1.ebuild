# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/acidrip/acidrip-0.14-r1.ebuild,v 1.3 2007/07/02 15:21:47 peper Exp $

inherit perl-app

DESCRIPTION="A gtk-perl mplayer/mencoder frontend for ripping DVDs"
HOMEPAGE="http://untrepid.com/acidrip/"
SRC_URI="mirror://sourceforge/acidrip/${P}.tar.gz"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="encode"

DEPEND="dev-lang/perl
		dev-perl/gtk2-perl
		>=media-video/lsdvd-0.10
		media-video/mplayer
		encode? ( >=media-sound/lame-3.92 )"
