# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.9.3-r2.ebuild,v 1.11 2005/08/13 00:09:22 humpback Exp $

inherit eutils qt3

VER="0.9.3"
REV=""
MY_PV="${VER}${REV}"
MY_P="${PN}-${MY_PV}"
HTTPMIRR="http://gentoo-pt.org/~humpback/psi"
IUSE="kde ssl crypt extras"
#RESTRICT="nomirror"
QV="2.0"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"
# translations from http://tanoshi.net/language.html
# polish translation contains special texts for patches from extras-version
SRC_URI="mirror://sourceforge/psi/${MY_P}.tar.bz2
		extras?	( http://gentoo-pt.org/~humpback/${PN}-${VER}-gentoo-extras-0.1.tar.bz2
		http://gentoo-pt.org/~humpback/${PN}-${VER}-gentoo-extras-0.2.tar.bz2
		http://gentoo-pt.org/~humpback/${PN}-${VER}-gentoo-extras-0.3.tar.bz2 )
		linguas_ar? ( ${HTTPMIRR}/psi_ar-0.9.3.tar.bz2 )
		linguas_ca? ( ${HTTPMIRR}/psi_ca-0.9.3.tar.bz2 )
		linguas_cs? ( ${HTTPMIRR}/psi_cs-0.9.3-a.tar.bz2 )
		linguas_da? ( ${HTTPMIRR}/psi_da-0.9.3.tar.bz2 )
		linguas_de? ( ${HTTPMIRR}/psi_de-0.9.3-c.tar.bz2 )
		linguas_ee? ( ${HTTPMIRR}/psi_ee-0.9.3_rc1.tar.bz2 )
		linguas_el? ( ${HTTPMIRR}/psi_el-0.9.3-a.tar.bz2 )
		linguas_eo? ( ${HTTPMIRR}/psi_eo-0.9.3-c.tar.bz2 )
		linguas_es? ( ${HTTPMIRR}/psi_es-0.9.3-a.tar.bz2 )
		linguas_et? ( ${HTTPMIRR}/psi_et-0.9.3-a.tar.bz2 )
		linguas_fi? ( ${HTTPMIRR}/psi_fi-0.9.3.tar.bz2 )
		linguas_fr? ( ${HTTPMIRR}/psi_fr-0.9.3-a.tar.bz2 )
		linguas_it? ( ${HTTPMIRR}/psi_it-0.9.3.tar.bz2 )
		linguas_jp? ( ${HTTPMIRR}/psi_jp-0.9.3.tar.bz2 )
		linguas_mk? ( ${HTTPMIRR}/psi_mk-0.9.3-a.tar.bz2 )
		linguas_nl? ( ${HTTPMIRR}/psi_nl-0.9.3-b.tar.bz2 )
		linguas_pl? ( ${HTTPMIRR}/psi_pl-0.9.3-1.tar.bz2 )
		linguas_pt? ( ${HTTPMIRR}/psi_pt-0.9.3.tar.bz2 )
		linguas_ptBR? ( ${HTTPMIRR}/psi_ptbr-0.9.3.tar.bz2 )
		linguas_ru? ( ${HTTPMIRR}/psi_ru-0.9.3-a.tar.bz2 )
		linguas_se? ( ${HTTPMIRR}/psi_se-0.9.3_rc1.tar.bz2 )
		linguas_sk? ( ${HTTPMIRR}/psi_sk-0.9.3-a.tar.bz2 )
		linguas_sl? ( ${HTTPMIRR}/psi_sl-0.9.3-a.tar.bz2 )
		linguas_sr? ( ${HTTPMIRR}/psi_sr-0.9.3.tar.bz2 )
		linguas_sv? ( ${HTTPMIRR}/psi_sv-0.9.3.tar.bz2 )
		linguas_sw? ( ${HTTPMIRR}/psi_sw-0.9.3.tar.bz2 )
		linguas_vi? ( ${HTTPMIRR}/psi_vi-0.9.3-a.tar.bz2 )
		linguas_zh? ( ${HTTPMIRR}/psi_zh-0.9.3-a.tar.bz2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc hppa ~amd64 sparc"

#After final relase we do not need this
S="${WORKDIR}/${MY_P}"

DEPEND=">=app-crypt/qca-1.0-r2
	$(qt_min_version 3.3)"

RDEPEND="ssl? ( >=app-crypt/qca-tls-1.0-r2 )
		crypt? ( >=app-crypt/gnupg-1.2.2 )"

PATCHBASE="${WORKDIR}"
PATCHDIR="${PATCHBASE}/${VER}"

src_unpack() {
		unpack ${A}

		cd ${S}
		epatch ${FILESDIR}/psi-pathfix.patch
		epatch ${FILESDIR}/psi-desktop.patch
		epatch ${FILESDIR}/psi-desktop_file_and_icons_directories.patch

		if ! use extras ; then
			ewarn "You are going to install the original psi version. You might want to"
			ewarn "try the version with extra unsuported patches by adding 'extras' to"
			ewarn "your use flags."
		else
			ewarn "You are about to build a version of Psi with extra unsuported patches."
			ewarn "Patched psi versions will not be supported by the Gentoo devs or the psi"
			ewarn "development team."
			ewarn "If you do not want that please press Control-C now and add '-extras' to "
			ewarn "your USE flags."
			ebeep
			epause 10

			cd ${S}
			# from http://www.cs.kuleuven.ac.be/~remko/psi/
			epatch ${PATCHDIR}/avatars_psi.diff
			epatch ${PATCHDIR}/jep8-avatars_psi.diff
			epatch ${PATCHDIR}/jep8-avatars_iris.diff
			epatch ${PATCHDIR}/rosteritems_psi.diff
			epatch ${PATCHDIR}/rosteritems_iris.diff
			epatch ${PATCHDIR}/menubar_psi.diff

			# from http://machekku.uaznia.net/jabber/psi/patches/
			epatch ${PATCHDIR}/psi-machekku-smart_reply_and_forward.diff
			epatch ${PATCHDIR}/psi-machekku-quote_emoticons.diff
			epatch ${PATCHDIR}/psi-machekku-keep_message_in_auto_away_status.diff
			epatch ${PATCHDIR}/psi-machekku-emoticons_advanced_toggle.diff

			# from ftp://ftp.patryk.one.pl/pub/psi/skazi/patches/
			epatch ${PATCHDIR}/psi-weather_agent_icons-add.diff
			epatch ${PATCHDIR}/psi-rich_contactview-0.7-add.diff
			epatch ${PATCHDIR}/psi-status_indicator++-add.diff
			epatch ${PATCHDIR}/psi-options_resize-fix.diff
			epatch ${PATCHDIR}/psi-settoggles-fix.diff
			epatch ${PATCHDIR}/psi-line_in_options-mod.diff
			epatch ${PATCHDIR}/psi-empty_group-fix.diff
			epatch ${PATCHDIR}/psi-gnome_toolwindow-mod.diff
			epatch ${PATCHDIR}/psi-no_online_status-mod.diff
			epatch ${PATCHDIR}/psi-status_history-add.diff
			epatch ${PATCHDIR}/psi-icon_buttons_big_return-mod.diff
			epatch ${PATCHDIR}/psi-nicechats-mod.diff
			epatch ${PATCHDIR}/psi-framechecks-mod.diff
			epatch ${PATCHDIR}/psi-thin_borders-mod.diff

			# indicator icon
			cp ${PATCHBASE}/psi-indicator.png ${S}/iconsets/roster/default/indicator.png
			# additional files
			cp ${PATCHBASE}/psi-richlistview.cpp ${S}/src/richlistview.cpp
			cp ${PATCHBASE}/psi-richlistview.h ${S}/src/richlistview.h
			cp ${PATCHBASE}/psi-roster-rich.README ${S}/README.rich-roster

			# from http://machekku.uaznia.net/jabber/psi/patches/
			epatch ${PATCHDIR}/psi-machekku-emoticons_advanced_toggle-add_richroster.diff

			# from ftp://ftp.patryk.one.pl/pub/psi/selfmade/patches/
			epatch ${PATCHDIR}/psi-group_openclose_single_click_not_only_arrow-mod.diff

			# from pld-linux.org
			epatch ${PATCHDIR}/psi-certs.patch
			epatch ${PATCHDIR}/psi-customos.patch
			epatch ${PATCHDIR}/psi-icondef.xml_status_indicator.patch

			# from http://mrulik.dyndns.info/psi/
			epatch ${PATCHDIR}/filetransfer.diff
			epatch ${PATCHDIR}/FT_port_already_bound.diff
			epatch ${PATCHDIR}/emergency_button.diff
			epatch ${PATCHDIR}/offline_statuses_in_roster.diff
			# emergency icon
			cp ${PATCHBASE}/psi-emergency.png ${S}/iconsets/system/default/emergency.png

			# from ftp://ftp.patryk.one.pl/pub/psi/patches/
			epatch ${PATCHDIR}/psi-psz-chatdlg_typed_msgs_history.diff
			epatch ${PATCHDIR}/psi-psz-global_hotkeys.diff

			# from http://kg.alternatywa.info/psi/patche/
			epatch ${PATCHDIR}/psi-status-timeout-kfix.diff
			epatch ${PATCHDIR}/psi-kg-spoof.diff
			epatch ${PATCHDIR}/psi-kg-individual_status_add.diff.no
			epatch ${PATCHDIR}/psi-kg-new-transports-icons.diff
			epatch ${PATCHDIR}/psi-kg-pl-specific-clients-avatars.diff
			epatch ${PATCHDIR}/psi-kg-says_mod.diff
			epatch ${PATCHDIR}/psi-psz-srv_lookup_enable-kfix.diff
			epatch ${PATCHDIR}/psi-subs_reason-recv.diff
			epatch ${PATCHDIR}/psi-subs_reason-send-kfix.diff
			epatch ${PATCHDIR}/psi-apa-invite_reason2-add.diff
			epatch ${PATCHDIR}/psi-kg-hide-disabled-emottoolbutton.diff

			# from http://michalj.alternatywa.info/psi/patches/
			epatch ${PATCHDIR}/psi-emots-mod.diff

			# from http://www.cs.kuleuven.ac.be/~remko/psi/rc/
			epatch ${PATCHDIR}/adhoc+rc.diff

			# from http://machekku.uaznia.net/jabber/psi/patches/
			epatch ${PATCHDIR}/psi-machekku-autocopy_on_select.diff
			epatch ${PATCHDIR}/psi-machekku-enable_thread_in_messages.diff
			epatch ${PATCHDIR}/psi-machekku-contact_icons_at_top-for_psi-psz.diff
			epatch ${PATCHDIR}/psi-machekku-linkify_fix.diff
			epatch ${PATCHDIR}/psi-machekku-new_headings_gui_resurrection.diff

			# from http://home.unclassified.de/files/psi/patches/
			epatch ${PATCHDIR}/statusdlg-enterkey.diff
			epatch ${PATCHDIR}/hide-no-resource-from-contextmenu.diff
			epatch ${PATCHDIR}/fix-window-flashing.diff
			epatch ${PATCHDIR}/fix-min-window-notify.diff
			epatch ${PATCHDIR}/contact-icon-space.diff
			epatch ${PATCHDIR}/fix-rich-roster.diff
			epatch ${PATCHDIR}/custom-sound-popup.diff
			epatch ${PATCHDIR}/offline-contact-animation.diff

			# from bugs.gentoo.org
			epatch ${PATCHDIR}/psi-add-status-history.patch

			# from http://www.uni-bonn.de/~nieuwenh/
			epatch ${PATCHDIR}/libTeXFormula.diff

			# few more goodies :)
			epatch ${PATCHDIR}/psi-richroster-status_default_on.patch
			epatch ${PATCHDIR}/psi-richroster-status_gui_on_off.patch
			epatch ${PATCHDIR}/psi-roster_right_align_group_names.patch
			epatch ${PATCHDIR}/psi-chatdlg_messages_colors_distinguishes.patch
			epatch ${PATCHDIR}/psi-gentoo-version.patch
			epatch ${PATCHDIR}/psi-reverse_trayicon.patch
		fi
		einfo ""
		einfo "Unpacking language files, you must have linguas_* in USE where"
		einfo "* is the language files you wish. English is always available"
		einfo ""
		cd ${WORKDIR}
		if ! [ -d langs ] ; then
			mkdir langs
		fi
		local i
		for i in  `ls -c1 | grep "\.{ts,qm}$"` ; do
			mv $i langs
		done
}


src_compile() {
	use kde || myconf="${myconf} --disable-kde"
	./configure --prefix=/usr $myconf || die "Configure failed"
	# for CXXFLAGS from make.conf
	${QTDIR}/bin/qmake psi.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		|| die "Qmake failed"

	addwrite "$HOME/.qt"
	addwrite "$QTDIR/etc/settings"
	emake || die "Make failed"

	einfo "Building language packs"
	cd ${WORKDIR}/langs
	for i in `ls -c1 | grep "\.ts$"` ; do
		${QTDIR}/bin/lrelease $i
	done;
}

src_install() {
	make INSTALL_ROOT="${D}" install

	#this way the docs will also be installed in the standard gentoo dir
	for i in roster system emoticons; do
		newdoc ${S}/iconsets/${i}/README README.${i}
	done;
	newdoc certs/README README.certs
	dodoc README TODO README.rich-roster

	#Install language packs
	cp ${WORKDIR}/langs/psi_*.qm ${D}/usr/share/psi/
}
