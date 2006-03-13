# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/volume/volume-0.5.ebuild,v 1.1 2006/03/13 16:44:15 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Tweak your sound card volume from Emacs"
HOMEPAGE="http://www.brockman.se/software/volume-el/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

# NOTE we might define the following which volume.el can work with by
# default, but volume.el can really work with anything.

# RDEPEND="|| ( media-sound/aumixer media-sound/alsa-utils )" 

SITEFILE=50volume-gentoo.el
