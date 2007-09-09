# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.10-r3.ebuild,v 1.4 2007/09/09 16:06:30 josejx Exp $

inherit eutils qt3

IUSE="ssl crypt xscreensaver extras audacious insecure-patches"
LANGS="ar bg ca cs da de el eo es et fi fr it hu mk nl pl pt pt_BR ru se sk sl
sr sr sw_TZ vi zh"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
# translations from http://tanoshi.net/language.html
# polish translation contains special texts for patches from extras-version
HTTPMIRR="http://vivid.dat.pl/psi"
SRC_URI="mirror://sourceforge/psi/${P}.tar.bz2
		extras? ( ${HTTPMIRR}/gentoo-${P}.tar.bz2
			${HTTPMIRR}/gentoo-${P}-r2.tar.bz2
			insecure-patches? ( ${HTTPMIRR}/psi-extras-insecure.tar.bz2 ) )
		linguas_ar? ( ${HTTPMIRR}/psi_ar-0.9.3.tar.bz2 )
		linguas_bg? ( ${HTTPMIRR}/psi_bg-0.10-b-1.tar.bz2 )
		linguas_ca? ( ${HTTPMIRR}/psi_ca-0.10-a-1.tar.bz2 )
		linguas_cs? ( ${HTTPMIRR}/psi_cs-0.10-a-1.tar.bz2 )
		linguas_da? ( ${HTTPMIRR}/psi_da-0.9.3.tar.bz2 )
		linguas_de? ( ${HTTPMIRR}/psi_de-0.10-a-1.tar.bz2 )
		linguas_el? ( ${HTTPMIRR}/psi_el-0.9.3-a.tar.bz2 )
		linguas_eo? ( ${HTTPMIRR}/psi_eo-0.10-a.tar.bz2 )
		linguas_es? ( ${HTTPMIRR}/psi_es-0.10-a.tar.bz2 )
		linguas_et? ( ${HTTPMIRR}/psi_et-0.10-a-1.tar.bz2 )
		linguas_fi? ( ${HTTPMIRR}/psi_fi-0.9.3.tar.bz2 )
		linguas_fr? ( ${HTTPMIRR}/psi_fr-0.10-a-1.tar.bz2 )
		linguas_it? ( ${HTTPMIRR}/psi_it-0.10-a-1.tar.bz2 )
		linguas_hu? ( ${HTTPMIRR}/psi_hu-0.10-a.tar.bz2 )
		linguas_mk? ( ${HTTPMIRR}/psi_mk-0.10-a.tar.bz2 )
		linguas_nl? ( ${HTTPMIRR}/psi_nl-0.10-a.tar.bz2 )
		linguas_pl? ( ${HTTPMIRR}/psi_pl-0.9.3-1.tar.bz2 )
		linguas_pt? ( ${HTTPMIRR}/psi_pt-0.10-a-1.tar.bz2 )
		linguas_pt_BR? ( ${HTTPMIRR}/psi_ptBR-0.10-a.tar.bz2 )
		linguas_ru? ( ${HTTPMIRR}/psi_ru-0.9.3-a.tar.bz2 )
		linguas_se? ( ${HTTPMIRR}/psi_se-0.9.3_rc1-1.tar.bz2 )
		linguas_sk? ( ${HTTPMIRR}/psi_sk-0.10-a-1.tar.bz2 )
		linguas_sl? ( ${HTTPMIRR}/psi_sl-0.10-b-1.tar.bz2 )
		linguas_sr? ( ${HTTPMIRR}/psi_sr-0.10-a-1.tar.bz2 )
		linguas_sv? ( ${HTTPMIRR}/psi_sv-0.9.3.tar.bz2 )
		linguas_sw_TZ? ( ${HTTPMIRR}/psi_sw-0.9.3.tar.bz2 )
		linguas_vi? ( ${HTTPMIRR}/psi_vi-0.10-b-1.tar.bz2 )
		linguas_zh? ( ${HTTPMIRR}/psi_zh-0.10-a-1.tar.bz2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 hppa ppc ppc64 ~sparc x86"

DEPEND=">=app-crypt/qca-1.0-r2
	$(qt_min_version 3.3)
	xscreensaver? ( x11-misc/xscreensaver )
	extras? ( audacious? ( media-sound/audacious ) )"

RDEPEND="${DEPEND}
	ssl? ( >=app-crypt/qca-tls-1.0-r2 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )"

PATCHBASE="${WORKDIR}"
PATCHDIR="${PATCHBASE}/${PV}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/psi-pathfix2.patch
	epatch ${FILESDIR}/psi-desktop2.patch
	epatch ${FILESDIR}/psi-reverse_trayicon2.patch
	epatch "${FILESDIR}/${P}-gpg2.patch"

	if ! use extras; then
		ewarn "You are going to install the original psi version. You might want to"
		ewarn "try the version with extra unsuported patches by adding 'extras' to"
		ewarn "your use flags."
	else
		ewarn "You are about to build a version of Psi with extra patches."
		ewarn "Patched psi versions will not be supported by the psi development team,"
		ewarn "but only (in limited scope) by the psi-gentoo patchset author."
		ewarn "If you find any problem with patched psi, first contact with"
		ewarn "troll@gentoo.org through the bugzilla or directly by email."
		ewarn
		ewarn "If you do not want patched psi version, please press Control-C now and"
		ewarn "add '-extras' to your USE flags."
		ebeep
		epause 10

		cd ${S}
		# from http://norman.rasmussen.co.za/darcs/psi-muc/
		epatch ${PATCHDIR}/psi-muc_support.patch
		epatch ${PATCHDIR}/psi-muc_support-update-20051123.patch
		epatch ${PATCHDIR}/psi-muc_support-update-20060114.patch

		# roster-nr
		epatch ${PATCHDIR}/psi-fix_popup_richtext.patch
		epatch ${PATCHDIR}/psi-roster-nr-0.9.14.patch
		epatch ${PATCHDIR}/psi-status_indicator++_add-on_roster-nr.patch
		# indicator icon
		cp ${FILESDIR}/psi-indicator.png ${S}/iconsets/roster/default/indicator.png

		# from http://www.cs.kuleuven.ac.be/~remko/psi/
		epatch ${PATCHDIR}/jep8-avatars_iris.diff
		epatch ${PATCHDIR}/jep8-avatars_psi.diff

		# from http://machekku.uaznia.net/jabber/psi/patches/
		epatch ${PATCHDIR}/psi-machekku-smart_reply_and_forward-0.5_psi-gentoo.diff
		epatch ${PATCHDIR}/psi-machekku-keep_message_in_auto_away_status.diff
		epatch ${PATCHDIR}/psi-machekku-quote_emoticons.diff
		epatch ${PATCHDIR}/psi-machekku-emoticons_advanced_toggle.diff
		epatch ${PATCHDIR}/psi-machekku-linkify_fix.diff
		epatch ${PATCHDIR}/psi-machekku-autostatus_while_dnd.diff
		epatch ${PATCHDIR}/psi-machekku-visual_styles_manifest.diff
		epatch ${PATCHDIR}/psi-machekku-tool_window_minimize_fix_for_windows.diff
		epatch ${PATCHDIR}/psi-machekku-new_character_counter.diff

		# from ftp://ftp.patryk.one.pl/pub/psi/skazi/patches/
		epatch ${PATCHDIR}/psi-options_resize-fix.diff
		epatch ${PATCHDIR}/psi-settoggles-fix.diff
		epatch ${PATCHDIR}/psi-line_in_options-mod.diff
		epatch ${PATCHDIR}/psi-empty_group-fix.diff
		epatch ${PATCHDIR}/psi-no_online_status-mod.diff
		epatch ${PATCHDIR}/psi-status_history-add-psi-gentoo.diff
		epatch ${PATCHDIR}/psi-icon_buttons_big_return-mod.diff
		epatch ${PATCHDIR}/psi-linkify-mod-rev-fix.diff
		epatch ${PATCHDIR}/psi-save_profile-mod.diff
		epatch ${PATCHDIR}/psi-url_emoticon-mod.diff
		epatch ${PATCHDIR}/psi-thin_borders-mod.diff

		# from http://www.uaznia.net/psi-daisy/patches/
		epatch ${PATCHDIR}/filetransfer.diff
		epatch ${PATCHDIR}/psi-emots-mod.diff
		epatch ${PATCHDIR}/psi_michalj_statusicon_in_chatdlg_titlebar.diff
		epatch ${PATCHDIR}/psi_michalj_custom_rostericons_in_tooltips.diff

		# from ftp://ftp.patryk.one.pl/pub/psi/patches/
		epatch ${PATCHDIR}/psi-psz-chatdlg_typed_msgs_history.diff

		# from http://kg.alternatywa.info/psi/patche/
		epatch ${PATCHDIR}/psi-status-timeout-kfix.diff
		epatch ${PATCHDIR}/psi-kg-spoof.diff
		epatch ${PATCHDIR}/psi-kg-individual_status_add.diff

		# from pld-linux.org
		epatch ${PATCHDIR}/psi-certs.patch

		# upstream patches from psi-flyspray
		epatch ${PATCHDIR}/psi-fix_groupsortingstyle_toggles.patch
		epatch ${PATCHDIR}/psi-multiple_account_groups.diff

		# from http://psi-pedrito.go.pl/
		epatch ${PATCHDIR}/pedrito-null-key-string-fix.diff
		epatch ${PATCHDIR}/pedrito-avatars-printf-off.diff
		epatch ${PATCHDIR}/pedrito-linkify_and_wrap-client.diff
		epatch ${PATCHDIR}/pedrito-group_menuitem_for_notinlist.diff

		# from psi-devel mailing list
		epatch ${PATCHDIR}/psi-history_lug.patch
		epatch ${PATCHDIR}/psi-history-deletion-bugfix.patch
		epatch ${PATCHDIR}/checkboxes-sound-options.diff

		# from http://mircea.bardac.net/psi/patches/
		epatch ${PATCHDIR}/psi-cli-v2.diff

		# from ubuntu
		epatch ${PATCHDIR}/psi-trayicon_ubuntu_fix.patch

		# from http://home.unclassified.de/files/psi/patches/
		epatch ${PATCHDIR}/statusdlg-enterkey.diff
		epatch ${PATCHDIR}/fix-min-window-notify.diff
		epatch ${PATCHDIR}/hide-no-resource-from-contextmenu.diff
		epatch ${PATCHDIR}/custom-sound-popup.patch
		epatch ${PATCHDIR}/offline-contact-animation.diff

		# from bugs.gentoo.org
		epatch ${PATCHDIR}/psi-add-status-history.patch

		# from http://rydz.homedns.org
		epatch ${PATCHDIR}/psi-filetransfer-finish-popup-qsorix.patch

		# from http://k.uaznia.net/jabber/psi/patches/
		epatch ${PATCHDIR}/a-psi-k-emergency_away_status_button.diff
		epatch ${PATCHDIR}/psi-evil_message_support.patch
		epatch ${PATCHDIR}/psi-auto_responder.patch
		epatch ${PATCHDIR}/psi-auto_responder_gui.patch

		# from http://www.cs.kuleuven.ac.be/~remko/psi/
		epatch ${PATCHDIR}/rosteritems_iris.diff
		# this one was chagned because of muc support
		epatch ${PATCHDIR}/rosteritems_psi_with_muc.diff

		# from http://delx.cjb.net/psi/
		epatch ${PATCHDIR}/psi-nicknames.patch

		# from http://norman.rasmussen.co.za/darcs/psi-rc/
		epatch ${PATCHDIR}/norman-rc.diff
		epatch ${PATCHDIR}/norman-darcs-20051129.diff
		# from http://machekku.uaznia.net/jabber/psi/patches/
		epatch ${PATCHDIR}/psi-machekku-rc_multiline_status_fix.diff
		# from http://norman.rasmussen.co.za/darcs/psi-rc/
		epatch ${PATCHDIR}/psi-dynamic-priority-rc-fix.diff
		epatch ${PATCHDIR}/norman-darcs-20051231.patch

		# created for psi-gentoo and roster-nr
		epatch ${PATCHDIR}/psi-smile_icon_emoticonset.patch
		epatch ${PATCHDIR}/psi-enable_avatars.patch
		epatch ${PATCHDIR}/psi-transport_icons_and_avatars.patch
		epatch ${PATCHDIR}/psi-client_avatars_icons.patch
		epatch ${PATCHDIR}/psi-emoticons_advanced_toggle-add-roster-nr.patch
		epatch ${PATCHDIR}/psi-chatdlg_messages_colors_distinguishes.patch
		epatch ${PATCHDIR}/psi-messages_color_backgrounds_in_chat.patch
		epatch ${PATCHDIR}/psi-sort-style-on-roster-nr.patch
		epatch ${PATCHDIR}/psi-says_mod.patch
		epatch ${PATCHDIR}/psi-muc_support_langpacks_fix.patch
		epatch ${PATCHDIR}/psi-copy_jid_or_status_message_to_clipboard.patch
		epatch ${PATCHDIR}/psi-timestamps_option_and_date_showing.patch
		epatch ${PATCHDIR}/psi-avatars_graph_settings_filetypes.patch
		epatch ${PATCHDIR}/psi-auto_responder_by_message.patch
		epatch ${PATCHDIR}/psi-taskbar_flashing.patch
		# by nelchael
		epatch ${PATCHDIR}/psi-nelchael-exec_command.patch
		epatch ${PATCHDIR}/psi-nelchael-disconnect-sleep.patch
		use audacious && epatch ${PATCHDIR}/psi-nelchael-audacious-status-0.3.patch

		if use insecure-patches; then
			# from http://www.uni-bonn.de/~nieuwenh/
			epatch ${PATCHDIR}/libTeXFormula.diff
			# from pld-linux.org
			epatch ${PATCHDIR}/psi-libTeXFormula-nicechats.patch
		fi;

		epatch ${PATCHDIR}/psi-gentoo-version.patch
	fi
}

src_compile() {
	# growl is mac osx extension only - maybe someday we will want this
	local myconf="--disable-growl"
	use xscreensaver || myconf="${myconf} --disable-xss"

	./configure --prefix=/usr ${myconf} || die "Configure failed"

	# fixes weird bugs : #150187 and #154556
	cd ${S}/libpsi/psiwidgets
	${QTDIR}/bin/qmake psiwidgets.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_RPATH= \
			|| die "Qmake failed"

	# for CXXFLAGS from make.conf
	cd ${S}/src
	${QTDIR}/bin/qmake src.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_RPATH= \
			|| die "Qmake failed"
	cd ${S}
	${QTDIR}/bin/qmake psi.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_RPATH= \
		|| die "Qmake failed"

	emake || die "Make failed"

	einfo "Building language packs"
	cd ${WORKDIR}/langs
	for i in `ls -c1 | grep "\.ts$"` ; do
		${QTDIR}/bin/lrelease $i
	done;
}

src_install() {
	einfo "Installing"
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
