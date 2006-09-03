# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korganizer/korganizer-3.5.2.ebuild,v 1.9 2006/09/03 16:03:08 kloeri Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkpimexchange)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)
$(deprange $PV $MAXKDEVER kde-base/ktnef)
$(deprange $PV $MAXKDEVER kde-base/kdepim-kresources)
$(deprange $PV $MAXKDEVER kde-base/kontact)
$(deprange 3.5.1 $MAXKDEVER kde-base/libkholidays)"

KMCOPYLIB="
	libkdepim libkdepim
	libkpimexchange libkpimexchange
	libkcal libkcal
	libkpimidentities libkpimidentities
	libktnef ktnef/lib
	libkcal_resourceremote kresources/remote
	libkpinterfaces kontact/interfaces
	libkholidays libkholidays"
KMEXTRACTONLY="
	libkpimexchange/
	libkcal/
	libkdepim/
	libkpimidentities/
	mimelib/
	ktnef/
	certmanager/lib/
	kresources/remote/
	kmail/kmailIface.h
	kontact/interfaces/
	libkholidays"
KMCOMPILEONLY="
	libemailfunctions"

# They seems to be used only by korganizer
KMEXTRA="
	kgantt
	kdgantt
	kontact/plugins/korganizer/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of korganizer deps.

#src_compile() {
#	export DO_NOT_COMPILE="kalarmd" && kde-meta_src_compile myconf configure
#	# generate "alarmdaemoniface_stub.h"
#	cd ${S}/kalarmd && make alarmdaemoniface_stub.h
#	# generate "alarmguiiface_stub.h"
#	cd ${S}/kalarmd && make alarmguiiface_stub.h
#	
#	kde-meta_src_compile make
#}
