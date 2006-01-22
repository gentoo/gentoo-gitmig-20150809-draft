# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knode/knode-3.5.1.ebuild,v 1.1 2006/01/22 22:53:02 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A newsreader for KDE"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange 3.5.0 $MAXKDEVER kde-base/libkdenetwork)
$(deprange $PV $MAXKDEVER kde-base/kontact)
$(deprange 3.5.0 $MAXKDEVER kde-base/libkmime)"

KMCOPYLIB="
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces
	libkmime libkmime
	libkpgp libkpgp"
KMEXTRACTONLY="
	libkdepim/
	libkdenetwork/
	kontact/interfaces
	libkmime
	libkpgp
	libemailfunctions"
KMEXTRA="kontact/plugins/knode" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
