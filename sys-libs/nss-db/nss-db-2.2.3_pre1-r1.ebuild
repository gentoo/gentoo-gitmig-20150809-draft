# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/nss-db/nss-db-2.2.3_pre1-r1.ebuild,v 1.3 2006/03/16 21:11:11 pauldv Exp $

inherit eutils versionator multilib

MY_PN="${PN/-/_}"
MY_PV="${PV/_}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Allows important system files to be stored in a fast database file rather than plain text"
HOMEPAGE="http://sources.redhat.com/glibc/"
SRC_URI="ftp://sources.redhat.com/pub/glibc/releases/${MY_P}.tar.gz
		 mirror://gentoo/${MY_P}-external.patch.bz2
		 mirror://gentoo/${MY_P}-dbupgrade.patch.bz2
		 mirror://gentoo/${MY_P}-dbopen.patch.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="nls"

# awk and make ARE needed at runtime!
# and this didn't compile on BSD libc either
RDEPEND=">=sys-libs/db-4
		 sys-apps/gawk
		 sys-devel/make
		 >=sys-libs/glibc-2.3"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/autoconf
	sys-apps/sed"

S="${WORKDIR}/${MY_P}"

db_getver() {
	local DBPKG
	DBPKG="$(best_version '>=sys-libs/db-4*')"
	echo "${DBPKG//sys-libs\/db-}"
}

db_getversym() {
	local DBVER DBSYMSUFFIX
	[ -n "${1}" ] && DBVER="${1}" || DBVER="$(db_getver)"
	DBVER=($(get_version_components "${DBVER}"))
	if has_version '>=sys-libs/db-4.3'; then
		DBSYMSUFFIX=""
	else
		let DBSYMSUFFIX=(${DBVER[0]}*1000)+${DBVER[1]}
		DBSYMSUFFIX=_${DBSYMSUFFIX}
	fi
	echo "${DBSYMSUFFIX}"
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${MY_P}-external.patch.bz2
	EPATCH_OPTS="-p0 -d ${S}" epatch ${DISTDIR}/${MY_P}-dbupgrade.patch.bz2
	EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${MY_P}-dbopen.patch.bz2
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-root-upgrade-only.patch

	# make sure we use the correct version of DB
	cd ${S}
	DB_PV="$(db_getver)"
	DB_SYM="$(db_getversym ${DB_PV})"
	DB_PV_MAJORMINOR="$(get_version_component_range 1-2 ${DB_PV})"
	sed -i configure.in \
		-e "s!db.h!db${DB_PV_MAJORMINOR}/db.h!g" \
		-e "s!db, db_version!db-${DB_PV_MAJORMINOR}, db_version${DB_SYM}!g"

	# fix ancient broken-ness
	for f in po/Makefile.in.in ./intl/Makefile.in; do
		egrep -q '^mkinstalldirs = .*case.*esac' ${f} && \
		sed -i ${f} \
			-e '/^mkinstalldirs = /s,\(mkinstalldirs =\).*,\1 $(top_builddir)/./mkinstalldirs,'
	done

	# apply stuff
	libtoolize --copy --force
	export WANT_AUTOMAKE="1.4"
	export WANT_AUTOCONF="2.5"
	automake --add-missing || die "automake failed"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	econf -C --libdir=/$(get_libdir) `use_enable nls` || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install

	into /usr
	insinto /usr/share/${PN}
	doins db-Makefile

	exeinto /usr/sbin
	doexe ${FILESDIR}/remake-all-db

	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog INSTALL NEWS README THANKS
}
