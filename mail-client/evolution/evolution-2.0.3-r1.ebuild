# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/evolution/evolution-2.0.3-r1.ebuild,v 1.3 2005/03/23 16:17:35 seemant Exp $

inherit eutils gnome2 flag-o-matic alternatives

DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
HOMEPAGE="http://ximian.com/products/evolution/"

LICENSE="GPL-2"
SLOT="2.0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~hppa ~ia64 ~mips ~alpha"
IUSE="ssl mozilla ldap doc spell ipv6 kerberos crypt nntp debug pda"

# Top stanza are ximian deps
RDEPEND=">=gnome-extra/libgtkhtml-3.2.4
	>=gnome-extra/gal-2.2.4
	>=gnome-extra/evolution-data-server-1.0.3
	>=net-libs/libsoup-2.2.1
	>=dev-libs/glib-2
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2
	>=gnome-extra/yelp-2.5.1
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonoboui-2.4.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2
	>=gnome-base/libgnomeprintui-2
	>=x11-themes/gnome-icon-theme-1.2
	>=gnome-base/orbit-2.9.8
	mail-filter/spamassassin
	pda? ( >=app-pda/gnome-pilot-2.0.10
		>=app-pda/gnome-pilot-conduits-2.0.10 )
	spell? ( >=app-text/gnome-spell-1.0.5 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	ssl? ( mozilla? ( www-client/mozilla )
		!mozilla? ( >=dev-libs/nspr-4.4.1
			>=dev-libs/nss-3.9.2 ) )
	ldap? ( >=net-nds/openldap-2 )
	kerberos? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	>=sys-devel/libtool-1.4.1-r1
	>=dev-util/intltool-0.30
	sys-devel/gettext
	sys-devel/bison
	>=app-text/scrollkeeper-0.3.10-r1
	doc? ( dev-util/gtk-doc )"

G2CONF="--disable-default-binary \
	$(use_enable ssl nss) \
	$(use_enable ssl smime) \
	$(use_enable ipv6) \
	$(use_enable nntp) \
	$(use_enable pda pilot-conduits)"

USE_DESTDIR="1"
DOCS="AUTHORS COPYING* ChangeLog HACKING MAINTAINERS NEWS README"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}
	# bug #66166 -- temporary workaround until new baselayout exists
	epatch ${FILESDIR}/${P}-gentoo_etc_services.patch
	# bug #79183 -- fix security vulnerability in camel
	cd ${S}
	epatch ${FILESDIR}/${PN}-2-CAN-2005-0102.patch
}

src_compile() {
	# problems with -O3 on gcc-3.3.1
	replace-flags -O3 -O2

	if [ "${ARCH}" = "hppa" ]; then
		append-flags "-fPIC -ffunction-sections"
		export LDFLAGS="-ffunction-sections -Wl,--stub-group-size=25000"
	fi

	cd ${S}
	local myconf=""

	use ldap \
		&& myconf="${myconf} --with-openldap=yes --with-static-ldap=no" \
		|| myconf="${myconf} --with-openldap=no"

	use kerberos \
		&& myconf="${myconf} --with-krb5=/usr" \
		|| myconf="${myconf} --without-krb5"

	myconf="${myconf} --with-kde-applnk-path=no"

	# Use Mozilla's NSS/NSPR libs if 'mozilla' *and* 'ssl' in USE
	# Use standalone NSS/NSPR if only 'ssl' in USE
	# Openssl support doesn't work and has been disabled in cvs

	if use ssl ; then
		if  use mozilla ; then
			NSS_LIB=/usr/lib/mozilla
			NSPR_LIB=/usr/lib/mozilla
			NSS_INC=/usr/lib/mozilla/include/nss
			NSPR_INC=/usr/lib/mozilla/include/nspr
		else
			NSS_LIB=/usr/lib/nss
			NSPR_LIB=/usr/lib/nspr
			NSS_INC=/usr/include/nss
			NSPR_INC=/usr/include/nspr
		fi

		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${NSPR_INC} \
			--with-nspr-libs=${NSPR_LIB} \
			--with-nss-includes=${NSS_INC} \
			--with-nss-libs=${NSS_LIB}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
		--without-nss-libs --without-nss-includes"
	fi

	gnome2_src_configure ${G2CONF} ${myconf}

	emake || make || die "make failed"
}

pkg_postinst() {

	alternatives_auto_makesym "/usr/bin/evolution" "/usr/bin/evolution-[0-9].[0-9]"
	gnome2_gconf_install ${GCONFFILEPATH}
	einfo "To change the default browser if you are not using GNOME, do:"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/http/command -t string 'mozilla %s'"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/https/command -t string 'mozilla %s'"
	einfo ""
	einfo "Replace 'mozilla %s' with which ever browser you use."

}
