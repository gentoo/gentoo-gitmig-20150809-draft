# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.4.1-r1.ebuild,v 1.6 2005/08/16 10:55:19 dragonheart Exp $

inherit eutils flag-o-matic

ECCVER=0.1.6
ECCVER_GNUPG=1.4.0

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )
	ecc? ( http://alumnes.eps.udl.es/%7Ed4372211/src/${PN}-${ECCVER_GNUPG}-ecc${ECCVER}.diff.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="bzip2 caps curl ecc idea ldap nls readline selinux smartcard usb zlib X"

#static not working yet
#!static? (
#			ldap? ( net-nds/openldap )
#			bzip2? ( app-arch/bzip2 )
#			zlib? ( sys-libs/zlib )
#		)

RDEPEND="
	ldap? ( net-nds/openldap )
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	nls? ( sys-devel/gettext )
	curl? ( net-misc/curl )
	virtual/libc
	virtual/mta
	readline? ( sys-libs/readline )
	smartcard? ( dev-libs/libusb )
	selinux? ( sec-policy/selinux-gnupg )
	usb? ( dev-libs/libusb )"

RDEPEND="${RDEPEND}
	X? ( || (  media-gfx/xloadimage media-gfx/xli ) )"

DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
	fi

	if use ecc; then
		# this trickery is because the only reject in the 1.4.0 patch is the
		# version number!
		local eccpatch=${WORKDIR}/${PN}-${ECCVER_GNUPG}-ecc${ECCVER}.diff
		if [ "${ECCVER_GNUPG}" != "${PV}" ]; then
			einfo "Tweaking PV in ECC patch"
			sed -i "s/ VERSION='${ECCVER_GNUPG}/ VERSION='${PV}/g" $eccpatch
		fi
		EPATCH_OPTS="-p1 -d ${S}" epatch $eccpatch
	fi

	# maketest fix
	epatch ${FILESDIR}/${P}-selftest.patch

	# Fix PIC definitions
	cd ${S}
	sed -i -e 's:PIC:__PIC__:' mpi/i386/mpih-{add,sub}1.S intl/relocatable.c
	sed -i -e 's:if PIC:ifdef __PIC__:' mpi/sparc32v8/mpih-mul{1,2}.S
}

src_compile() {
	# Certain sparc32 machines seem to have trouble building correctly with
	# -mcpu enabled.  While this is not a gnupg problem, it is a temporary
	# fix until the gcc problem can be tracked down.
	if [ "${ARCH}" == "sparc" ] && [ "${PROFILE_ARCH}" == "sparc" ]; then
		filter-flags -mcpu=supersparc -mcpu=v8 -mcpu=v7
	fi

	# `USE=static` support was requested in #29299
	# use static && append-ldflags -static

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	use sparc || myconf="${myconf} --enable-m-guard"

	use ppc-macos || append-ldflags -Wl,-z,now

	# configure doesn't trean --disable-asm correctly
	use x86 && myconf="${myconf} --enable-asm"


	# fix compile problem on ppc64
	use ppc64 && myconf="${myconf} --disable-asm"

	econf \
		$(use_enable ldap) \
		--enable-mailto \
		--enable-hkp \
		--enable-finger \
		$(use_with !zlib included-zlib) \
		$(use_with curl libcurl /usr) \
		$(use_enable nls) \
		$(use_enable bzip2) \
		$(use_enable smartcard card-support) \
		$(use_enable selinux selinux-support) \
		$(use_with caps capabilities) \
		$(use_with readline) \
		$(use_with usb libusb /usr) \
		$(use_enable X photo-viewers) \
		--enable-static-rnd=linux \
		--libexecdir=/usr/libexec \
		--enable-sha512 \
		${myconf} || die
	# this is because it will run some tests directly
	gnupg_fixcheckperms
	emake || die

	# NOTE libexecdir dir is deliberately different from that in the install
}

src_install() {
	gnupg_fixcheckperms
	emake DESTDIR=${D} libexecdir="/usr/libexec/gnupg" install || die

	# caps support makes life easier
	use caps || fperms u+s,go-r /usr/bin/gpg

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS PROJECTS README THANKS \
		TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	# Remove collissions
	if use ppc-macos; then
		rm ${D}/usr/lib/charset.alias ${D}/usr/share/locale/locale.alias
	fi
}

gnupg_fixcheckperms() {
	# GnuPG does weird things for testing that it build correctly
	# as we as for the additional tests. It WILL fail with perms 770 :-(.
	# See bug #80044
	if has userpriv ${FEATURES}; then
		einfo "Fixing permissions in check directory"
		chown -R portage:portage ${S}/checks
		chmod -R ugo+rw ${S}/checks
		chmod ugo+rw ${S}/checks
	fi
}

src_test() {
	gnupg_fixcheckperms
	einfo "Running tests"
	emake check
	ret=$?
	if [ $ret -ne 0 ]; then
		die "Some tests failed! Please report to the Gentoo Bugzilla"
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
	if use idea; then
		einfo "-----------------------------------------------------------------------------------"
		einfo "IDEA"
		ewarn "you have compiled ${PN} with support for the IDEA algorithm, this code"
		ewarn "is distributed under the GPL in countries where it is permitted to do so"
		ewarn "by law."
		einfo
		einfo "Please read http://www.gnupg.org/why-not-idea.html for more information."
		einfo
		ewarn "If you are in a country where the IDEA algorithm is patented, you are permitted"
		ewarn "to use it at no cost for 'non revenue generating data transfer between private"
		ewarn "individuals'."
		einfo
		einfo "Countries where the patent applies are listed here"
		einfo "http://www.mediacrypt.com/_contents/10_idea/101030_ea_pi.asp"
		einfo
		einfo "Further information and other licenses are availble from http://www.mediacrypt.com/"
		einfo "-----------------------------------------------------------------------------------"
	fi
	if use ecc; then
		einfo
		ewarn "The elliptical curves patch is experimental"
		einfo "Further info available at http://alumnes.eps.udl.es/%7Ed4372211/index.en.html"
	fi
	if use caps; then
		einfo
		ewarn "Capabilities code is experimental"
	fi
	einfo
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo
}
