# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realone/realone-1.ebuild,v 1.7 2003/05/11 13:21:00 liquidx Exp $

IUSE="gnome kde"

inherit virtualx

DESCRIPTION="RealOne player is a streaming media player, AKA RealPlayer9"
HOMEPAGE="http://realforum.real.com/cgi-bin/unixplayer/wwwthreads.pl"
INSTALL_BINARY="r1p1_linux22_libc6_i386_a1.bin"
RV9_PATCH="rv9_libc6_i386_cs2.tgz"
SRC_URI="http://docs.real.com/docs/playerpatch/unix/${RV9_PATCH}
	 http://195.141.101.151/direct/${INSTALL_BINARY}"

SLOT="0"
KEYWORDS="~x86 -ppc -sparc "
LICENSE="realone" # The LICENSE file in /opt/RealPlayer9

DEPEND="virtual/x11"
RDEPEND=""
RESTRICT="nostrip nomirror"

S=${WORKDIR}

INS="/opt/RealPlayer9"
RN="${INS}/realnetworks"
REAL="${INS}/Real"
APPLNK="share/applnk/Multimedia"

# Some small files the player needs
CONFIG_Gemini="pluginfilepath=${REAL}/RCAPlugins\n"
CONFIG_RealMediaSDK="skinsdirectory=${INS}/Skins\nusersdkdatapath=\${HOME}\n\
externalresourcesdirectory=${REAL}/Plugins/ExtResources\n"
CONFIG_RealShared="dt_plugins=${REAL}/Plugins/\ndt_codecs=${REAL}/Codecs/\n\
dt_update_ob=${REAL}/Update_OB/\ndt_common=${REAL}/Common/\ndt_encsdk=${REAL}\
/Tools/\ndt_objbrokr=${REAL}/Common/\ndt_rcaplugins=${REAL}/RCAPlugins/\n"
CONFIG_RealPlayer="mainapp=${INS}/realplay\n\
clientlicensekey=00000000000090000114000000007FF7FF00\n"
# License key appears to be identical with every download (do verify)

src_unpack() {
	tar xfz ${DISTDIR}/${RV9_PATCH}
	cp ${DISTDIR}/${INSTALL_BINARY} .
	chmod 755 ${INSTALL_BINARY}
}

src_install() {
	echo
	einfo "This ebuild installs RealOne player with RV9 system-wide."
	einfo "Starting GUI installer in an Xvfb session. Hang on..."
	echo

	# Virtualmake
	unset DISPLAY # make sure it uses the virtualx rather than realx (#19293)
	export maketype="./${INSTALL_BINARY}"
	virtualmake < /dev/null >& /dev/null &
	while ! [ -r rnsetup/realplaydoc.xpm ]
	do 
		sleep 1
	done
	killall ${INSTALL_BINARY}

	# Install main files
	cd rnsetup
	insinto ${INS} ; exeinto ${INS}
	doins LICENSE README audiosig.rm firstrun.* libXm.so.2 *.xpm
	doexe GEMAPP/gemini realplay realplay_
	insinto ${INS}/Help ; doins HELP/*
	insinto ${INS}/Help/pics ; doins HELPIMGS/*
	insinto ${REAL}/Codecs ; doins RACODECS/* RVCODECS/*
	insinto ${REAL}/Common/
	doins AppMasterDB DTMasterDB rmacore.so.6.0 \
		GEMSETUP/objbrokr.so.0.1 MAINUI/pnrscmgr.so.6.0
	touch ${D}/${REAL}/Common/DTAdditionsDB
	touch ${D}/${REAL}/Common/DTLocalDB
	insinto ${REAL}/Plugins/ExtResources ; doins coreres60.xrs
	insinto ${REAL}/Plugins
	doins AUDP/audplin.so.6.0 FLASH/* GEMSETUP/imgrplin.so.6.0 \
		GEMSETUP/smplfsys.so.6.0 GEMSETUP/xmlparse.so.6.1 \
		GEMSETUP/zipfsys.so.6.0 H261/h261rndr.so.6.0 \
		H263/h263rend.so.6.0 MP3/* MP3PL/mp3mfpln.so.6.0 \
		MULTICST/ppffplin.so.6.0 PLINS/* RTPLINS/* pnxres.so.6.0 \
		rarender.so.6.0 rvrend.so.6.0 VIDP/vidplin.so.6.0 VSRCPLIN/*
	insinto ${REAL}/RCAPlugins
	doins EMBED/chinembed.so.6.0 EMBED/chui.so.9.0 \
		GEMAPPPLN/gemproduct.so.0.1 GEMSETUP/gemactors.so.0.1 \
		GEMSETUP/gemctrls.so.0.1 GEMSETUP/gemctrls2.so.0.1 \
		GEMSETUP/gemxcomps.so.0.1 GEMSETUP/uisystem.so.0.1 \
		MAINUI/chfs.so.6.0 RCAPLYBK/*
	insinto ${REAL}/Update_OB
	doins GEMSETUP/faust.so.7.0 GEMSETUP/setuplib.so.7.0 UPDATE/*
	insinto ${REAL}/Update_OB/UI ; doins UI/* FAUST/ath.vs

	# NS plugin is a nogo; http://plugindoc.mozdev.org/linux.html#RealOne
	# The files are left in /opt/RealPlayer9/WBPlugin for now
	insinto ${INS}/WBPlugin
	doins EMBED/nppl3260.xpt EMBED/nprealplayer.so.6.0 EMBED/raclass.zip

	# RV9 update
	insinto ${REAL}/Plugins ; doins ../rv9/plugins/rvrend.so.6.0
	insinto ${REAL}/Codecs ; doins ../rv9/codecs/*

	# Config files that are needed by the player
	echo -e ${CONFIG_Gemini} > Gemini_0_1
	echo -e ${CONFIG_RealMediaSDK} > RealMediaSDK_6_0
	echo -e ${CONFIG_RealPlayer} > RealPlayer_9_0 
	echo -e ${CONFIG_RealShared} > RealShared_0_0
	insinto ${RN}	
	doins Gemini_0_1 RealMediaSDK_6_0 RealPlayer_9_0 RealShared_0_0

	# KDE desktop entry
	if [ -n "`use kde`" -a -n "${KDEDIR}" ]; then
		insinto ${KDEDIR}/${APPLNK}
		doins ${FILESDIR}/realone.desktop
	fi
    
    # Gnome desktop entry
    if [ -n "`use gnome`" ]; then
    	insinto /usr/share/applications
        doins ${FILESDIR}/realone.desktop
    fi
    
    # Install pixmaps
	insinto /usr/share/pixmaps
	doins *.xpm    

	# Wrapper script
	exeinto /opt/bin
	doexe ${FILESDIR}/realone
}

pkg_postinst() {
	einfo "The RealOne player has been installed into ${INS}."
	einfo "You can start it by running the wrapper script 'realone'."
	einfo "Netscape plugin was not installed because it is defunct."
	if [ ${KDEDIR} ]; then
		einfo "A KDE desktop entry for RealOne has been installed."
	fi
	echo
	einfo "You must agree to the EULA in ${INS}/LICENSE or unmerge."
	echo
}

# BUGS likely introduced by this ebuild:
# User bookmarks are not saved, because user can't write to ${INS}
# Player freezes when Version button in the About window is pressed

# BUGS not caused by this ebuild:
# Some menu items are not functional
# Auto update doesn't work and probably won't any time soon
# Netscape plugin is broken and proper file naming unclear

# BUG fixed by this ebuild:
# Player can't handle filenames containing spaces. Fixed in wrapper.
# Thanks to Sridhar Dhanapalan who discovered this bug.
