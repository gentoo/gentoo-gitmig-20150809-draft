# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/evolution/evolution-1.4.5.ebuild,v 1.16 2004/03/23 15:14:44 avenj Exp $

# kde before gnome2, otherwise kde_src_install will override gnome2_src_install
use kde && inherit kde
inherit flag-o-matic virtualx gnome2

# problems with -O3 on gcc-3.3.1
replace-flags -O3 -O2

DB3="db-3.1.17"
S="${WORKDIR}/${P}"
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="${SRC_URI} http://www.sleepycat.com/update/snapshot/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

IUSE="ssl mozilla ldap doc spell pda ipv6 kerberos kde crypt"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc hppa alpha amd64"

# Top stanza are ximian deps
RDEPEND=">=gnome-extra/libgtkhtml-3.0.9
	>=gnome-extra/gal-1.99.10
	>=net-libs/libsoup-1.99.26
	>=gnome-extra/yelp-2.2
	pda? ( >=app-pda/gnome-pilot-2.0.10-r1
	       >=app-pda/pilot-link-0.11.8
	       >=app-pda/gnome-pilot-conduits-2.0.10-r1 )
	spell? ( >=app-text/gnome-spell-1.0.5 )
	>=gnome-base/ORBit2-2.8.2
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnome-2.0
	>=dev-libs/libxml2-2.5
	>=gnome-base/gconf-2.0
	>=gnome-base/libgnomecanvas-2.2.0.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomeprint-2.2
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	ssl? ( mozilla? ( || ( ( >=dev-libs/nspr-4.3 >=dev-libs/nss-3.8 )
	                       net-www/mozilla
	                     )
	                ) )
	ssl? ( !mozilla? ( >=dev-libs/openssl-0.9.5 ) )
	ldap? ( >=net-nds/openldap-2.0 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.5 )
	doc? ( >=app-text/scrollkeeper-0.3.10-r1 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	>=sys-devel/libtool-1.4.1-r1
	>=dev-util/intltool-0.20
	sys-devel/gettext
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	if [ -x ${ROOT}/usr/bin/evolution-1.3 ]; then
		eerror "Please un-merge the 1.3 Development Versions of Ximian Evolution."
		eerror "You can do this by doing:"
		eerror ""
		eerror "   emerge -C \"=net-mail/evolution-1.3*\""
		eerror ""
		die "unmerge evolution-1.3 before installing evolution-1.4"
	fi
}

src_unpack() {
	unpack ${A}

	# Remove dependency on libdb1.so (its deprecated)
	cd ${S}; sed -i -e "s/-ldb1//" configure

	# We need the omf fix, or else we get access violation
	# errors related to sandbox
	gnome2_omf_fix ${S}/help/C/Makefile.in

	# Patch for 64-bit ... should be retired for 1.5 which contains
	# the patch upstream
	epatch ${FILESDIR}/evolution-1.4.4-alpha.patch
	# Patch backported from CVS. Fixes NZDT (UTC+13) timezone on emails
	# http://bugzilla.ximian.com/show_bug.cgi?id=49357
	cd ${S}/camel; epatch ${FILESDIR}/${P}-nztimezone.patch

}

##### Compile evolution specific db3 for static linking #####
src_compile_db3() {
	einfo "Compiling DB3..."
	cd ${WORKDIR}/${DB3}/build_unix
	../dist/configure --prefix=${WORKDIR}/db3 || die

	# Rather ugly hack to make sure pthread mutex support are not enabled ...
	if [ -n "`egrep "^LIBS=[[:space:]]*-lpthread" Makefile`" ];  then
		append-flags "-pthread"
	fi

	make || die "db make failed"
	make prefix=${WORKDIR}/db3 install || die "db install failed"

}

src_compile() {
	elibtoolize

	if [ "${ARCH}" = "hppa" ]; then
		append-flags "-fPIC -ffunction-sections"
		export LDFLAGS="-ffunction-sections -Wl,--stub-group-size=25000"
	fi

	# Compile evo specific version of db3
	src_compile_db3

	einfo "Compiling Evolution..."
	cd ${S}

	local myconf=

	use pda \
		&& myconf="${myconf} --with-pisock=/usr --enable-pilot-conduits=yes" \
		|| myconf="${myconf} --enable-pilot-conduits=no"

	use ldap \
		&&	myconf="${myconf} --with-openldap=yes --with-static-ldap=no" \
		|| myconf="${myconf} --with-openldap=no"

	use kerberos \
		&& myconf="${myconf} --with-krb5=/usr" \
		|| myconf="${myconf} --without-krb5"

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6=yes" \
		|| myconf="${myconf} --enable-ipv6=no"

	use kde && [ -n "${KDEDIR}" ] \
		&& myconf="${myconf} --with-kde-applnk-path=${KDEDIR}/share/applnk"

	# Use Mozilla NSS/NSPR libs if 'mozilla' *and* 'ssl' in USE
	if [ -n "`use ssl`" -a -n "`use mozilla`" ] ; then
		if has_version "dev-libs/nspr"; then
			NSS_LIB=/usr/lib
			NSS_INC=/usr/include
		elif has_version "net-www/mozilla"; then
			NSS_LIB=/usr/lib/mozilla
			NSS_INC=/usr/lib/mozilla/include
		else
			eerror "Neither net-www/mozilla nor dev-libs/nspr found."
			die "unexpected error. unable to find nss/nspr"
		fi

		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${NSS_INC}/nspr \
			--with-nspr-libs=${NSS_LIB} \
			--with-nss-includes=${NSS_INC}/nss \
			--with-nss-libs=${NSS_LIB}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	# Else use OpenSSL if 'mozilla' not in USE  ...
	if [ -n "`use ssl`" -a -z "`use mozilla`" ] ; then
		myconf="${myconf} --enable-openssl=yes"
	fi

	econf --with-db3=${WORKDIR}/db3 ${myconf} || die

	# Needs to be able to connect to X display to build.
	Xemake || Xmake || die "make failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	einfo "To change the default browser if you are not using GNOME, do:"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/http/command -t string 'mozilla %s'"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/https/command -t string 'mozilla %s'"
	einfo ""
	einfo "Replace 'mozilla %s' with which ever browser you use."
}

USE_DESTDIR="1"
DOCS="AUTHORS COPYING* ChangeLog HACKING MAINTAINERS NEWS README"
