# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksmserver/ksmserver-3.5.2.ebuild,v 1.1 2006/03/22 20:15:38 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

KMEXTRACTONLY="kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KMNODOCS=true
