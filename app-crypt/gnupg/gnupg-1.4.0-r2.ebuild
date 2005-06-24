# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.4.0-r2.ebuild,v 1.5 2005/06/24 22:01:43 agriffis Exp $

inherit eutils flag-o-matic

ECCVER=0.1.6

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )
	ecc? ( http://alumnes.eps.udl.es/%7Ed4372211/src/${P}-ecc${ECCVER}.diff.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc-macos ~s390 ~sparc ~x86 ~ia64 ~mips ~ppc64"
IUSE="ecc ldap nls readline caps zlib idea bzip2 selinux smartcard"
#
# Disabling X until media-gfx/xli has sufficient keywords
# missing ~alpha ~ia64 ~mips = bug #76234

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
	virtual/libc
	readline? ( sys-libs/readline )
	smartcard? ( dev-libs/libusb )
	selinux? ( sec-policy/selinux-gnupg )"


#	X? ( media-gfx/xloadimage media-gfx/xli )

# 	dev-lang/perl
#	virtual/mta


DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
	fi

	cd ${S}
	if use ecc; then
		epatch ${WORKDIR}/${P}-ecc${ECCVER}.diff || die "ecc patch failed"
	fi
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

	if ! use zlib; then
		myconf="${myconf} --with-included-zlib"
	else
		myconf="${myconf} --without-included-zlib"
	fi

	use ppc-macos || append-ldflags -Wl,-z,now

	if use ppc-macos && use caps; then
		eerror "Capabilities support is only available for Linux."
	fi

	# configure doesn't trean --disable-asm correctly
	use x86 && myconf="${myconf} --enable-asm"

	# 		`use_enable X photo-viewers` \
	#
	econf \
		`use_enable ldap` \
		--enable-mailto \
		--enable-hkp \
		--enable-finger \
		`use_enable nls` \
		`use_enable bzip2` \
		`use_enable smartcard card-support` \
		`use_enable selinux selinux-support` \
		`use_with caps capabilities` \
		`use_with readline` \
		--enable-static-rnd=linux \
		--libexecdir=/usr/libexec \
		--enable-sha512 \
		${myconf} || die
	emake || die

	# NOTE libexecdir dir is deliberately different from that in the install
}

src_install() {
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
		ewarn "Capabilites code is experimental"
	fi
	einfo
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo
}
