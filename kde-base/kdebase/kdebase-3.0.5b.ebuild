# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.0.5b.ebuild,v 1.6 2003/09/06 23:54:21 msterret Exp $
inherit eutils flag-o-matic kde-dist

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba"

DESCRIPTION="KDE ${PV} - base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86 ppc ~alpha sparc"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )
	sys-apps/gzip"
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

RDEPEND="${RDEPEND}
	sys-apps/eject"

myconf="${myconf} --with-dpms --with-cdparanoia"

use ldap	&& myconf="${myconf} --with-ldap" 	|| myconf="${myconf} --without-ldap"
use pam		&& myconf="${myconf} --with-pam"		|| myconf="${myconf} --with-shadow"
use motif	&& myconf="${myconf} --with-motif"	|| myconf="${myconf} --without-motif"
use encode	&& myconf="${myconf} --with-lame"		|| myconf="${myconf} --without-lame"
use cups	&& myconf="${myconf} --with-cups"		|| myconf="${myconf} --disable-cups"
use oggvorbis 	&& myconf="${myconf} --with-vorbis"	|| myconf="${myconf} --without-vorbis"
use opengl	&& myconf="${myconf} --with-gl"		|| myconf="${myconf} --without-gl"
use ssl		&& myconf="${myconf} --with-ssl"		|| myconf="${myconf} --without-ssl"
use pam		&& myconf="${myconf} --with-pam=yes"	|| myconf="${myconf} --with-pam=no --with-shadow"

get_xft_setup() {
	# This function tries to figure out if we have QT compiled against Xft1
	# or Xft2.0, and also if we have Xft1, Xft2.0 or a broken Xft setup
	# <azarah@gentoo.org> (24 Dec 2002)

	# Check if QT was compiled agaist Xft1 or Xft2 ... the idea is to only get
	# the major version of the linked lib if its Xft2, else it should be "" ..
	# we then set it to "1" with the next check.
	export QT_XFT_VER="`ldd ${QTDIR}/lib/libqt.so 2> /dev/null | grep "libXft" | awk '{split($1, ver, "."); print ver[3]}'`"
	[ -z "${QT_XFT_VER}" ] && QT_XFT_VER="1"

	# Check if the Xft headers are Xft1 or Xft2 ... the idea is to only get the
	# major version of the Xft version if its Xft2, else it should be "" ..
	# we then set it to "1" with the next check.
	local XFT_HDR_VER="`grep "XFT_MAJOR" /usr/X11R6/include/X11/Xft/Xft.h | awk '($2 == "XFT_MAJOR") {print $3}'`"
	[ -z "${XFT_HDR_VER}" ] && XFT_HDR_VER="1"

	# Check if the libs installed are Xft1 or Xft2 ...  We only check
	# what the /usr/X11R6/lib/libXft.so symlink poinst to, as that should
	# be 99% what apps will link to (except if we have Xft2 in /usr/lib,
	# but that should not matter) ...
	local XFT_LIB_VER="`readlink /usr/X11R6/lib/libXft.so 2> /dev/null | \
		awk '{split($0, file, "/"); for (x in file) if (file[x] ~ /libXft\.so\.2/) print file[x]}'`"
	[ "${XFT_LIB_VER/libXft}" != "${XFT_LIB_VER}" ] \
		&& XFT_LIB_VER="2" \
		|| XFT_LIB_VER="1"

	if [ "${XFT_HDR_VER}" -eq "2" -a "${XFT_LIB_VER}" -eq "2" ]
	then
		# Yep, we have Xft2 support ...
		export HAVE_XFT_2="yes"

	elif [ "${XFT_HDR_VER}" != "${XFT_LIB_VER}" ]
	then
		# Xft support are broken (mixed header and lib versions) ...
		export HAVE_XFT_2="broken"

	elif [ "${XFT_HDR_VER}" -eq "1" -a "${XFT_LIB_VER}" -eq "1" ]
	then
		# Nope, we only have Xft1 installed ...
		export HAVE_XFT_2="no"
	fi
}

pkg_setup() {

	# It should generally be considered bad form to touch files in the
	# live filesystem, but we had a broken Xft.h out there, and to expect
	# all users to update X because of it is harsh.  Also, there is no
	# official fix to xfree for this issue as of writing.  See bug #9423
	# for more info.
	cd /usr/X11R6/include/X11/Xft
	if patch --dry-run -p0 < ${FILESDIR}/${PVR}/${P}-xft_h-fix.diff > /dev/null
	then
		EPATCH_SINGLE_MSG="Patching Xft.h to fix missing defines..." \
		epatch ${FILESDIR}/${PVR}/${P}-xft_h-fix.diff
	fi

	get_xft_setup

	# Check what the setup are, and if things do not seem OK, die
	# with a hopefully helpful message ...
	if [ "${HAVE_XFT_2}" = "yes" -a "${QT_XFT_VER}" -eq "1" ]
	then
		eerror "You have Xft2.0 installed, but QT is linked against Xft1!"
		eerror
		eerror "Please fix this by remerging >=x11-libs/qt-3.1 and doing:"
		eerror
		eerror "  # emerge \">=x11-libs/qt-3.1\""
		die "You have Xft2.0 installed, but QT is linked against Xft1!"

	elif [ "${HAVE_XFT_2}" = "broken" ]
	then
		eerror "You have a broken Xft setup!  This could mean that you"
		eerror "have Xft2.0 headers with Xft1 libs, or reversed.  Please"
		eerror "fix this before you try to merge kdebase again."
		die "You have a broken Xft setup!"

	elif [ "${HAVE_XFT_2}" = "no" -a "${QT_XFT_VER}" -eq "2" ]
	then
		eerror "You have QT compiled against Xft2.0, but Xft2.0 is no"
		eerror "longer installed.  Please remerge QT, and then try"
		eerror "again to merge kdebase."
		die "You have QT compiled against Xft2.0, but Xft2.0 is no longer installed."
	fi
}

src_unpack() {

	kde_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${PVR}/${P}-nspluginviewer-qt31.diff.gz

	get_xft_setup

	# Apply this only if we have a Xft1.2 Xft.h or have Xft2.0 installed ...
	if [ -n "`grep "fontconfig" /usr/X11R6/include/X11/Xft/Xft.h`" ] || \
	   [ "${HAVE_XFT_2}" = "yes" ]
	then
		cd ${S}; epatch ${FILESDIR}/${PVR}/${P}-xft2.0-fix.diff
	fi
}

src_compile() {

	get_xft_setup

	# Add '-DXFT_WITH_FONTCONFIG' to our C[XX]FLAGS if we have a Xft.h that
	# uses fontconfig ... this will enable the fix in the '${P}-xft2.0-fix.diff'
	# patch.
	if [ -n "`grep "fontconfig" /usr/X11R6/include/X11/Xft/Xft.h`" ]
	then
		append-flags "-DXFT_WITH_FONTCONFIG"
	fi

	# Add '-DHAVE_XFT2' to our C[XX]FLAGS if we have Xft2.0 installed ...
	# this will enable the fix in the '${P}-xft2.0-fix.diff' patch.
	if [ "${HAVE_XFT_2}" = "yes" ]
	then
		append-flags "-DHAVE_XFT2"
	fi

	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {

	kde_src_install

	# cf bug #5953
	if [ "`use pam`" ]
	then
		insinto /etc/pam.d
		newins ${FILESDIR}/kscreensaver.pam kscreensaver
		newins ${FILESDIR}/kde.pam kde
	fi

	# startkde script
	cd ${D}/${KDEDIR}/bin
	epatch ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo.diff
	dosed "s:_KDEDIR_:${KDEDIR}:" ${KDEDIR}/bin/startkde
	chmod a+x startkde

	# x11 session script
	cd ${T}
	echo "#!/bin/sh
${KDEDIR}/bin/startkde" > kde-${PV}
	chmod a+x kde-${PV}
	# old scheme - compatibility
	exeinto /usr/X11R6/bin/wm
	doexe kde-${PV}
	# new scheme - for now >=xfree-4.2-r3 only
	exeinto /etc/X11/Sessions
	doexe kde-${PV}

	cd ${D}/${PREFIX}/share/config/kdm || die
	dosed "s:SessionTypes=:SessionTypes=kde-${PV},:" \
		${PREFIX}/share/config/kdm/kdmrc
	dosed "s:Session=${PREFIX}/share/config/kdm/Xsession:Session=/etc/X11/xdm/Xsession:" \
		${PREFIX}/share/config/kdm/kdmrc

	#backup splashscreen images, so they can be put back when unmerging
	#mosfet or so.
	if [ ! -d ${KDEDIR}/share/apps/ksplash.default ]
	then
		cd ${D}/${KDEDIR}/share/apps
		cp -rf ksplash/ ksplash.default
	fi

	# Show gnome icons when choosing new icon for desktop shortcut
	dodir /usr/share/pixmaps
	mv ${D}/${KDEDIR}/share/apps/kdesktop/pics/* ${D}/usr/share/pixmaps/
	rm -rf ${D}/${KDEDIR}/share/apps/kdesktop/pics/
	cd ${D}/${KDEDIR}/share/apps/kdesktop/
	ln -sf /usr/share/pixmaps/ pics

	# fix bug #12705: make sure default Xreset, Xsetup, Xwilling files are installed
	# into the kdm config dir
	cd ${S}/kdm/kfrontend
	./genkdmconf --in . --no-old
	insinto ${PREFIX}/share/config/kdm
	doins Xreset Xsetup Xstartup

	# portage has a problem working with empty directories
	rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir

}

pkg_postinst() {
	mkdir -p ${KDEDIR}/share/templates/.source/emptydir
}

