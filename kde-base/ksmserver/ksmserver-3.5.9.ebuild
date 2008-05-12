# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksmserver/ksmserver-3.5.9.ebuild,v 1.3 2008/05/12 16:43:07 armin76 Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

#SRC_URI="${SRC_URI}
#	mirror://gentoo/kdebase-3.5-patchset-07.tar.bz2"

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRACTONLY="kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KMNODOCS=true

# Re-add those patches later on.
#EPATCH_EXCLUDE="ksmserver-3.5.8-ksmserver_suspend.diff
#				ksmserver-3.5.8-suspend_configure.diff"
