# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-meta/kdeaddons-meta-3.4.0_beta1-r1.ebuild,v 1.4 2005/02/11 16:33:20 caleb Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86"
IUSE="sdl arts"

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/atlantikdesigner)
$(deprange $PV $MAXKDEVER kde-base/knewsticker-scripts)
$(deprange $PV $MAXKDEVER kde-base/ksig)
$(deprange $PV $MAXKDEVER kde-base/vimpart)
$(deprange $PV $MAXKDEVER kde-base/kaddressbook-plugins)
$(deprange $PV $MAXKDEVER kde-base/kate-openheader)
$(deprange $PV $MAXKDEVER kde-base/kate-snippets)
$(deprange $PV $MAXKDEVER kde-base/kate-textfilter)
$(deprange $PV $MAXKDEVER kde-base/kate-xmlcheck)
$(deprange $PV $MAXKDEVER kde-base/kate-xmltools)
$(deprange $PV $MAXKDEVER kde-base/kate-scripts)
$(deprange $PV $MAXKDEVER kde-base/kate-htmltools)
$(deprange $PV $MAXKDEVER kde-base/kate-modeline)
$(deprange $PV $MAXKDEVER kde-base/kate-kpybrowser)
$(deprange $PV $MAXKDEVER kde-base/kate-cppsymbolviewer)
$(deprange $PV $MAXKDEVER kde-base/kate-filelistloader)
$(deprange $PV $MAXKDEVER kde-base/kate-tabbarextension)
$(deprange $PV $MAXKDEVER kde-base/kicker-applets)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/konqueror-akregator)
$(deprange $PV $MAXKDEVER kde-base/konqueror-crashes)
$(deprange $PV $MAXKDEVER kde-base/konqueror-khtmlsettingsplugin)
$(deprange $PV $MAXKDEVER kde-base/konqueror-arkplugin)
$(deprange $PV $MAXKDEVER kde-base/konqueror-autorefresh)
$(deprange $PV $MAXKDEVER kde-base/konqueror-babelfish)
$(deprange $PV $MAXKDEVER kde-base/konqueror-dirfilter)
$(deprange $PV $MAXKDEVER kde-base/konqueror-domtreeviewer)
$(deprange $PV $MAXKDEVER kde-base/konqueror-fsview)
$(deprange $PV $MAXKDEVER kde-base/konqueror-imagerotation)
$(deprange $PV $MAXKDEVER kde-base/konqueror-kimgalleryplugin)
$(deprange $PV $MAXKDEVER kde-base/konqueror-kuick)
$(deprange $PV $MAXKDEVER kde-base/konqueror-minitools)
$(deprange $PV $MAXKDEVER kde-base/konqueror-rellinks)
$(deprange $PV $MAXKDEVER kde-base/konqueror-searchbar)
$(deprange $PV $MAXKDEVER kde-base/konqueror-sidebar)
$(deprange $PV $MAXKDEVER kde-base/konqueror-smbmounter)
$(deprange $PV $MAXKDEVER kde-base/konqueror-uachanger)
$(deprange $PV $MAXKDEVER kde-base/konqueror-validators)
$(deprange $PV $MAXKDEVER kde-base/konqueror-webarchiver)
$(deprange $PV $MAXKDEVER kde-base/renamedlg-audio)
$(deprange $PV $MAXKDEVER kde-base/renamedlg-images)
sdl? (
$(deprange $PV $MAXKDEVER kde-base/noatun-blurscope)
$(deprange $PV $MAXKDEVER kde-base/noatun-synaescope)
$(deprange $PV $MAXKDEVER kde-base/noatun-tyler)
$(deprange $PV $MAXKDEVER kde-base/noatun-tippercanoe)
)
arts? (
$(deprange $PV $MAXKDEVER kde-base/noatun-pitchablespeed)
$(deprange $PV $MAXKDEVER kde-base/noatun-wavecapture)
$(deprange $PV $MAXKDEVER kde-base/noatun-alsaplayer)
)
$(deprange $PV $MAXKDEVER kde-base/noatun-alarm)
$(deprange $PV $MAXKDEVER kde-base/noatun-charlatan)
$(deprange $PV $MAXKDEVER kde-base/noatun-dub)
$(deprange $PV $MAXKDEVER kde-base/noatun-ffrs)
$(deprange $PV $MAXKDEVER kde-base/noatun-luckytag)
$(deprange $PV $MAXKDEVER kde-base/noatun-lyrics)
$(deprange $PV $MAXKDEVER kde-base/noatun-noatunmadness)
$(deprange $PV $MAXKDEVER kde-base/noatun-oblique)
"

# the below are disabled from compialtion by upstream. ebuilds exist, but the software
# likely just doesn't work.
BROKEN="
$(deprange $PV $MAXKDEVER kde-base/kate-filetemplates)
$(deprange $PV $MAXKDEVER kde-base/kate-helloworld)
$(deprange $PV $MAXKDEVER kde-base/kate-insertcommand)
$(deprange $PV $MAXKDEVER kde-base/kate-kjswrapper)
$(deprange $PV $MAXKDEVER kde-base/kate-make)
sdl? ( $(deprange $PV $MAXKDEVER kde-base/noatun-nexscope) )
"
