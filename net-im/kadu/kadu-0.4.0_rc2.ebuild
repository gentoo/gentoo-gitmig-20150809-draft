# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.4.0_rc2.ebuild,v 1.1 2005/03/18 15:11:32 sekretarz Exp $

inherit flag-o-matic eutils

VTCL="20050308"
VTABS="r34"
VAMAROK="1.12"
WEATHER="2.01"
EXT_INFO="1.2"
XMMS="1.24"
XOSD_NOTIFY="050227"
MAIL="0.2.0"
SPELLCHECKER="0.13"
SPY="0.0.6"
CHESS="0.3-Calista"
FIREWALL="20050308"
LED_NOTIFY="0.1"

DESCRIPTION="QT client for popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"
	
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="debug alsa arts esd voice speech nas oss spell ssl tcltk xmms xosd amarok pheaders extraicons extramodules mail"

DEPEND="x11-libs/qt
	alsa? ( media-libs/alsa-lib virtual/alsa )
	arts? ( kde-base/arts )
	amarok? ( media-sound/amarok )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	pheaders? ( >=sys-devel/gcc-3.4.0 )
	spell? ( app-dicts/aspell-pl )
	ssl? ( dev-libs/openssl )
	speech? ( app-accessibility/powiedz )
	tcltk? ( >=dev-lang/tcl-8.4.0 >=dev-lang/tk-8.4.0 )
	xmms? ( media-sound/xmms )
	xosd? ( x11-libs/xosd )"

SRC_URI="http://kadu.net/download/stable/${P/_/-}.tar.bz2
	http://biprowod.wroclaw.pl/kadu/tabs-${VTABS}.tar.bz2
	amarok? ( http://scripts.one.pl/amarok/devel/0.4.0/amarok-${VAMAROK}.tar.gz )
	tcltk? ( http://scripts.one.pl/tcl4kadu/files/snapshots/tcl_scripting-${VTCL}.tar.gz )
	extraicons? (
	    http://biprowod.wroclaw.pl/kadu/kadu-theme-alt_cryst.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-crystal-16.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-crystal-22.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-gg3d.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-noia-16.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-nuvola-16.tar.gz
	    http://www.kadu.net/download/additions/kadu-theme-nuvola-22.tar.gz
	    http://www.kadu.net/download/additions/kadu-theme-old_default.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-piolnet.tar.bz2
	    http://www.kadu.net/download/additions/kadu-theme-real_gg.tar.bz2 )
	extramodules? ( 
	    http://pcb45.tech.us.edu.pl/~blysk/weather/weather-${WEATHER}.tar.bz2
	    http://nkg.republika.pl/files/ext_info-${EXT_INFO}.tar.bz2 
	    http://pcb45.tech.us.edu.pl/~tomek/kadu/kadu-spy-${SPY}.tar.bz2 
	    http://users.skorpion.wroc.pl/arturmat/firewall/files/firewall-${FIREWALL}.tar.bz2
	    http://biprowod.wroclaw.pl/kadu/KaduChess-${CHESS}.tar.bz2 
	    http://pcb45.tech.us.edu.pl/~blysk/led_notify/led_notify-${LED_NOTIFY}.tar.bz2 )
	xmms? ( http://scripts.one.pl/xmms/devel/0.4.0/xmms-${XMMS}.tar.gz )
	xosd? ( http://www.kadu.net/~joi/xosd_notify/xosd_notify-${XOSD_NOTIFY}.tar.bz2 )
	mail? ( http://michal.kernel-panic.cjb.net/mail/tars/release/mail-${MAIL}.tar.bz2 )
	spell? ( http://scripts.one.pl/spellchecker/devel/0.4.0/spellchecker-${SPELLCHECKER}.tar.gz )"


S=${WORKDIR}/${PN}

enable_module() {
	if use ${1}; then
	    mv ${WORKDIR}/${2} ${WORKDIR}/kadu/modules/ 
	    module_config ${2} m
	fi
}

module_config() {
	sed -i -r "s/(^module_${1}\\s*=\\s*).*/\\1${2}/" .config
}

src_unpack() {
    unpack ${A}
    cd ${S}

    # Disabling autodownload for modules
    rm -f ${WORKDIR}/kadu/modules/*.web

    # Disabling autodownload for icons
    rm -f ${WORKDIR}/kadu/varia/themes/icons/*.web

    # Disabling all modules and iconsets for further activation via USE flags 
    sed .config -i -e 's/=m/=n/g'
    sed .config -i -e 's/=y/=n/g'

    enable_module amarok amarok
    enable_module spell spellchecker 
    enable_module xmms xmms
    enable_module xosd xosd_notify
    enable_module mail mail
    enable_module tcltk "tcl_scripting"

    enable_module extramodules weather
    enable_module extramodules ext_info
    enable_module extramodules spy
    enable_module extramodules led_notify
    enable_module extramodules tabs

    # put some patches
    epatch ${FILESDIR}/${P}-libgsm-amd64.patch
    use nas && epatch ${FILESDIR}/${P}-nas-gentoo.diff
    use xosd && epatch ${FILESDIR}/xosd-gentoo.patch
}

src_compile() {
	filter-flags -fno-rtti

	# Enabling default iconset
	module_config icons_default y

	# Enabling dependencies that are needed by other modules
	module_config account_management m
	module_config autoaway m
	module_config autoresponder m
	module_config config_wizard m
	module_config dcc m
	module_config default_sms m
	module_config docking m
	module_config filedesc m
	module_config hints m
	module_config notify m
	module_config sms m
	module_config sound m

	if use extramodules; then
		if use !tcltk; then
			ewarn "script_chess depends on module_tcl_scripting;"
			ewarn "It won't be installed."
		fi
	fi

	# Firewall                                                              
	if use extramodules; then
		if use !tcltk; then
			ewarn "script_firewall depends on module_tcl_scripting;"
			ewarn "It won't be installed."
		fi
	fi

	use speech && module_config speech m
	use extramodules && module_config autoresponder

	# static modules (disable only, do not compile as .so)
	use ssl && module_config encryption y

	# dynamic modules
	use alsa && module_config alsa_sound m
	use arts && module_config arts_sound m
	use esd && module_config esd_sound m
	use nas && module_config nas_sound m
	use voice && module_config voice m

	# Some fixes                                                                                    
	if use extramodules; then
	    einfo "Changing default firewall log location to user's homedir/.gg/firewall.log"
	    sed ${WORKDIR}/firewall.tcl -i -e 's%$module(scriptpath)/firewall.log%$env(HOME)/.gg/firewall.log%g'
	fi
	
	local myconf
	myconf="${myconf} --enable-modules --enable-dist-info=Gentoo"
	
	use voice && myconf="${myconf} --enable-dependency-tracing"
	use debug && myconf="${myconf} --enable-debug"
	use pheaders && myconf="${myconf} --enable-pheaders"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die

	# Installing additional scripts and plugins
	# Chess and Firewall
	if use extramodules; then
	    if use tcltk; then
		einfo "Installing Chess script"
		mv ${WORKDIR}/KaduChess/{data,pics,KaduChess.tcl} ${D}/usr/share/kadu/modules/data/tcl_scripting/scripts
		# small fix form author's site
		sed ${D}/usr/share/kadu/modules/data/tcl_scripting/scripts/KaduChess.tcl -i -e 's/on chat0 KC_recv KC_recv/on chat0 KC_recv/g'
	    
		einfo "Installing Firewall module"
		mv ${WORKDIR}/firewall{.tcl,.png} ${D}/usr/share/kadu/modules/data/tcl_scripting/scripts
	    fi
	fi

	if use extraicons; then
	    einfo "Installing extra icons"
	    mv ${WORKDIR}/kadu-theme-crystal-16 ${D}/usr/share/kadu/themes/icons/crystal-16
	    mv ${WORKDIR}/kadu-theme-crystal-22 ${D}/usr/share/kadu/themes/icons/crystal-22
	    mv ${WORKDIR}/kadu-theme-gg3d ${D}/usr/share/kadu/themes/icons/gg3d
	    mv ${WORKDIR}/kadu-theme-noia-16 ${D}/usr/share/kadu/themes/icons/noia-16
	    mv ${WORKDIR}/kadu-theme-nuvola-16 ${D}/usr/share/kadu/themes/icons/nuvola-16
	    mv ${WORKDIR}/kadu-theme-nuvola-22 ${D}/usr/share/kadu/themes/icons/nuvola-22
	    mv ${WORKDIR}/kadu-theme-piolnet ${D}/usr/share/kadu/themes/icons/piolnet
	    mv ${WORKDIR}/kadu-theme-real_gg ${D}/usr/share/kadu/themes/icons/real_gg
	    mv ${WORKDIR}/alt_cryst ${D}/usr/share/kadu/themes/icons/alt_cryst
	fi
}
