# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/evolution/evolution-1.4.0.ebuild,v 1.1 2003/06/10 15:10:00 liquidx Exp $

IUSE="ssl mozilla ldap doc spell pda ipv6 kerberos kde"

inherit flag-o-matic virtualx debug gnome2
use kde && inherit kde

DB3="db-3.1.17"
S="${WORKDIR}/${P}"
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="${SRC_URI} http://www.sleepycat.com/update/snapshot/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

# top stanza are ximian deps
RDEPEND=">=gnome-extra/libgtkhtml-3.0.5
    >=gnome-extra/gal-1.99.7
    >=net-libs/libsoup-1.99.23
	pda?     ( >=gnome-extra/gnome-pilot-2.0.9
		>=dev-libs/pilot-link-0.11.7
		>=gnome-extra/gnome-pilot-conduits-2.0.9 )
	spell?   ( >=app-text/gnome-spell-1.0.4 )
	
	>=gnome-base/ORBit2-2.6.0
    >=gnome-base/libbonoboui-2.0
    >=gnome-base/gnome-vfs-2.0
    >=gnome-base/libgnomeui-2.0
    >=gnome-base/libglade-2.0
    >=gnome-base/libgnome-2.0
    >=gnome-base/bonobo-activation-2.2.1
    >=dev-libs/libxml2-2.5
    >=gnome-base/gconf-2.0
    >=gnome-base/libgnomecanvas-2.2.0.2
    >=gnome-base/libgnomeprintui-2.2
    >=gnome-base/libgnomeprint-2.2
	doc?	 ( >=app-text/scrollkeeper-0.3.10-r1 )
	ssl? ( mozilla? ( >=net-www/mozilla-0.9.9 ) : ( >=dev-libs/openssl-0.9.5 ) )
	ldap?    ( >=net-nds/openldap-2.0 )
    kerberos? ( >=app-crypt/mit-krb5-1.2.5 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
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
	# remove dependency on libdb1.so (its deprecated)
	cd ${S}; sed -i -e "s/-ldb1//" configure
	# fix desktop link
	epatch ${FILESDIR}/evolution-1.4.0-bad-1.3.patch
}

##### compile evolution specific db3 for static linking #####
src_compile_db3() {
	einfo "Compiling DB3..."
	cd ${WORKDIR}/${DB3}/build_unix
	../dist/configure --prefix=${WORKDIR}/db3 || die

	# Rather ugly hack to make sure pthread mutex support are not enabled ...
	if [ -n "`egrep "^LIBS=[[:space:]]*-lpthread" Makefile`" ];  then
		append-flags "-pthread"
	fi

	make || die
	make prefix=${WORKDIR}/db3 install || die

}

src_compile() {

	# compile evo specific version of db3
	src_compile_db3

	einfo "Compiling Evolution..."
	cd ${S}
  
	local myconf=""
	local MOZILLA="${MOZILLA_FIVE_HOME}"

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

	# Use Mozilla NSS libs if 'mozilla' *and* 'ssl' in USE
	if [ -n "`use ssl`" -a -n "`use mozilla`" ] ; then
		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${MOZILLA}/include/nspr \
			--with-nspr-libs=${MOZILLA} \
			--with-nss-includes=${MOZILLA}/include/nss \
			--with-nss-libs=${MOZILLA}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	# Else use OpenSSL if 'mozilla' not in USE  ...
	if [ -n "`use ssl`" -a -z "`use mozilla`" ] ; then
		myconf="${myconf} --enable-openssl=yes"
	fi

	econf --with-db3=${WORKDIR}/db3 ${myconf} || die

	# regenerate evolution.desktop
	cd ${S}/data; make evolution.desktop; cd ${S}

	#needs to be able to connect to X display to build.
	Xemake || Xmake || die
}

src_install() {
	export USE_DESTDIR="1"
	export DOCS="AUTHORS COPYING* ChangeLog HACKING MAINTAINERS NEWS README"
	gnome2_src_install
}	
