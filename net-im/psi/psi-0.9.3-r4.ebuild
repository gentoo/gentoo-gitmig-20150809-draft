# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.9.3-r4.ebuild,v 1.13 2005/08/13 00:09:22 humpback Exp $

inherit eutils qt3

VER="${PV}"
REV=""
MY_PV="${VER}${REV}"
MY_P="${PN}-${MY_PV}"
HTTPMIRR="http://gentoo-pt.org/~humpback/psi"
IUSE="kde ssl crypt extras"
QV="2.0"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"
# translations from http://tanoshi.net/language.html
# polish translation contains special texts for patches from extras-version
SRC_URI="mirror://sourceforge/psi/${MY_P}.tar.bz2
		extras? ( ${HTTPMIRR}/${PN}-${VER}-gentoo-extras-0.5.tar.bz2  )
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
#Amd64 devs: I now have a x86 and amd64 boxes so I can now test
#and mark on both arches
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"

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
		epatch ${FILESDIR}/psi-reverse_trayicon.patch

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
			# roster-nr
			epatch ${PATCHDIR}/psi-roster-nr-0.7.patch
			epatch ${FILESDIR}/psi-status_indicator++_add-on_roster-nr.patch
			# indicator icon
			cp ${FILESDIR}/psi-indicator.png ${S}/iconsets/roster/default/indicator.png

			# from http://www.cs.kuleuven.ac.be/~remko/psi/
			epatch ${PATCHDIR}/rosteritems_iris.diff
			epatch ${PATCHDIR}/rosteritems_psi.diff
			epatch ${PATCHDIR}/avatars_psi.diff
			epatch ${PATCHDIR}/jep8-avatars_iris.diff
			epatch ${PATCHDIR}/jep8-avatars_psi.diff
			epatch ${PATCHDIR}/caps_broadcast.diff
			epatch ${PATCHDIR}/menubar_psi.diff
			epatch ${PATCHDIR}/adhoc+rc.diff

			# from http://machekku.uaznia.net/jabber/psi/patches/
			epatch ${PATCHDIR}/psi-machekku-smart_reply_and_forward.diff
			epatch ${PATCHDIR}/psi-machekku-keep_message_in_auto_away_status.diff
			epatch ${PATCHDIR}/psi-machekku-quote_emoticons.diff
			epatch ${PATCHDIR}/psi-machekku-emoticons_advanced_toggle.diff
			epatch ${PATCHDIR}/psi-machekku-autocopy_on_select-0.2.diff
			epatch ${PATCHDIR}/psi-machekku-enable_thread_in_messages.diff
			epatch ${PATCHDIR}/psi-machekku-linkify_fix.diff
			epatch ${PATCHDIR}/psi-machekku-new_headings_gui_resurrection.diff
			epatch ${PATCHDIR}/psi-machekku-autostatus_while_dnd.diff
			epatch ${PATCHDIR}/psi-machekku-visual_styles_manifest.diff
			epatch ${PATCHDIR}/psi-machekku-gg_gateway_type.diff
			epatch ${PATCHDIR}/psi-machekku-tool_window_minimize_fix_for_windows.diff

			# from ftp://ftp.patryk.one.pl/pub/psi/skazi/patches/
			epatch ${PATCHDIR}/psi-options_resize-fix.diff
			epatch ${PATCHDIR}/psi-settoggles-fix.diff
			epatch ${PATCHDIR}/psi-line_in_options-mod.diff
			epatch ${PATCHDIR}/psi-empty_group-fix.diff
			epatch ${PATCHDIR}/psi-gnome_toolwindow-mod.diff
			epatch ${PATCHDIR}/psi-no_online_status-mod.diff
			epatch ${PATCHDIR}/psi-status_history-add.diff
			epatch ${PATCHDIR}/psi-icon_buttons_big_return-mod.diff
			epatch ${PATCHDIR}/psi-linkify-mod-rev-fix.diff
			epatch ${PATCHDIR}/psi-save_profile-mod.diff
			epatch ${PATCHDIR}/psi-url_emoticon-mod.diff
			epatch ${PATCHDIR}/psi-thin_borders-mod.diff
			epatch ${PATCHDIR}/psi-nicechats-mod.diff
			epatch ${PATCHDIR}/psi-subs_reason-recv.diff
			epatch ${PATCHDIR}/psi-subs_reason-send.diff

			# from http://michalj.alternatywa.info/psi/patches/
			epatch ${PATCHDIR}/filetransfer.diff
			epatch ${PATCHDIR}/emergency_button.diff
			epatch ${PATCHDIR}/psi-emots-mod.diff
			# emergency icon
			cp ${FILESDIR}/psi-emergency.png ${S}/iconsets/system/default/emergency.png

			# from ftp://ftp.patryk.one.pl/pub/psi/patches/
			epatch ${PATCHDIR}/psi-psz-chatdlg_typed_msgs_history.diff

			# from http://kg.alternatywa.info/psi/patche/
			epatch ${PATCHDIR}/psi-status-timeout-kfix.diff
			epatch ${PATCHDIR}/psi-kg-spoof.diff
			epatch ${PATCHDIR}/psi-kg-individual_status_add.diff.no
			epatch ${PATCHDIR}/psi-apa-invite_reason2-add.diff
			epatch ${PATCHDIR}/psi-kg-hide-disabled-emottoolbutton.diff

			# from http://home.unclassified.de/files/psi/patches/
			epatch ${PATCHDIR}/statusdlg-enterkey.diff
			epatch ${PATCHDIR}/fix-window-flashing.diff
			epatch ${PATCHDIR}/fix-min-window-notify.diff
			epatch ${PATCHDIR}/custom-sound-popup.diff
			epatch ${PATCHDIR}/offline-contact-animation.diff
			epatch ${PATCHDIR}/hide-no-resource-from-contextmenu.diff

			# from bugs.gentoo.org
			epatch ${FILESDIR}/psi-add-status-history.patch

			# from http://www.uni-bonn.de/~nieuwenh/
			epatch ${PATCHDIR}/libTeXFormula.diff

			# from pld-linux.org
			epatch ${PATCHDIR}/psi-certs.patch

			# upstream patches from psi-flyspray
			epatch ${PATCHDIR}/psi-fix_groupsortingstyle_toggles.patch
			epatch ${PATCHDIR}/psi-multiple_account_groups.diff

			# psi-devel mailing list
			epatch ${PATCHDIR}/checkboxes-sound-options.diff
			epatch ${PATCHDIR}/psi-history_lug.patch
			epatch ${PATCHDIR}/psi-cli-v2_gentoo.diff
			epatch ${FILESDIR}/vcard-photo-interface.patch
			epatch ${PATCHDIR}/psi-history-deletion-bugfix.patch

			# from http://tleilax.if.pw.edu.pl/~myak/
			epatch ${PATCHDIR}/psi-myak-taskbar_flashing.patch

			# created for psi-gentoo and roster-nr
			epatch ${PATCHDIR}/psi-transport_icons_and_avatars.patch
			epatch ${PATCHDIR}/psi-emoticons_advanced_toggle-add-roster-nr.patch
			epatch ${PATCHDIR}/psi-roster_right_align_group_names.patch
			epatch ${PATCHDIR}/psi-chatdlg_messages_colors_distinguishes.patch
			epatch ${PATCHDIR}/psi-messages_color_backgrounds_in_chat.patch
			epatch ${PATCHDIR}/psi-sort-contacts-style-on-roster-nr.patch
			epatch ${PATCHDIR}/psi-gentoo-version.patch
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
	make INSTALL_ROOT="${D}" install || die "Make install failed"

	#this way the docs will also be installed in the standard gentoo dir
	for i in roster system emoticons; do
		newdoc ${S}/iconsets/${i}/README README.${i}
	done;
	newdoc certs/README README.certs
	dodoc README TODO

	#Install language packs
	cp ${WORKDIR}/langs/psi_*.qm ${D}/usr/share/psi/
}

