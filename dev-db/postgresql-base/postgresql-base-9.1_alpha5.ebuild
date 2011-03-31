# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-base/postgresql-base-9.1_alpha5.ebuild,v 1.1 2011/03/31 02:29:25 titanofold Exp $

EAPI="4"

WANT_AUTOMAKE="none"

inherit autotools eutils multilib prefix versionator

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"

# Upstream doesn't have an underscore in the file name
MY_PV=${PV/_/}

DESCRIPTION="PostgreSQL libraries and clients"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${MY_PV}/postgresql-${MY_PV}.tar.bz2
		 http://dev.gentoo.org/~titanofold/postgresql-patches-${MY_PV}.tbz2"
LICENSE="POSTGRESQL"

S=${WORKDIR}/postgresql-${MY_PV}
SLOT="$(get_version_component_range 1-2)"

# No tests to be done for clients and libraries
RESTRICT="test"

LINGUAS="af cs de es fa fr hr hu it ko nb pl pt_BR ro ru sk sl sv tr zh_CN zh_TW"
IUSE="doc kerberos ldap nls pam pg_legacytimestamp readline ssl threads zlib"

for lingua in ${LINGUAS} ; do
	IUSE+=" linguas_${lingua}"
done

wanted_languages() {
	local enable_langs

	for lingua in ${LINGUAS} ; do
		use linguas_${lingua} && enable_langs+="${lingua} "
	done

	echo -n ${enable_langs}
}

RDEPEND="!!dev-db/postgresql-libs
	!!dev-db/postgresql-client
	!!dev-db/libpq
	!!dev-db/postgresql
	>=app-admin/eselect-postgresql-0.3
	virtual/libintl
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	readline? ( sys-libs/readline )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	nls? ( sys-devel/gettext )"
PDEPEND="doc? ( ~dev-db/postgresql-docs-${PV} )"

src_prepare() {
	epatch "${WORKDIR}/autoconf.patch" \
		"${WORKDIR}/base.patch"

	eprefixify src/include/pg_config_manual.h

	# to avoid collision - it only should be installed by server
	rm "${S}/src/backend/nls.mk"

	# because psql/help.c includes the file
	ln -s "${S}/src/include/libpq/pqsignal.h" "${S}/src/bin/psql/" || die

	eautoconf
}

src_configure() {
	export LDFLAGS_SL="${LDFLAGS}"
	econf \
		--prefix=${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT} \
		--datadir=${EROOT%/}/usr/share/postgresql-${SLOT} \
		--docdir=${EROOT%/}/usr/share/doc/postgresql-${SLOT} \
		--sysconfdir=${EROOT%/}/etc/postgresql-${SLOT} \
		--includedir=${EROOT%/}/usr/include/postgresql-${SLOT} \
		--mandir=${EROOT%/}/usr/share/postgresql-${SLOT}/man \
		--enable-depend \
		--without-tcl \
		--without-perl \
		--without-python \
		$(use_with readline) \
		$(use_with kerberos krb5) \
		$(use_with kerberos gssapi) \
		"$(use_enable nls nls "$(wanted_languages)")" \
		$(use_with pam) \
		$(use_enable !pg_legacytimestamp integer-datetimes) \
		$(use_with ssl openssl) \
		$(use_enable threads thread-safety) \
		$(use_with zlib) \
		$(use_with ldap)
}

src_compile() {
	emake

	cd "${S}/contrib"
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/include/postgresql-${SLOT}/postmaster
	doins "${S}"/src/include/postmaster/*.h

	dodir /usr/share/postgresql-${SLOT}/man/man1/
	cp  "${S}"/doc/src/sgml/man1/* "${ED}"/usr/share/postgresql-${SLOT}/man/man1/ || die

	rm "${ED}/usr/share/postgresql-${SLOT}/man/man1"/{initdb,pg_controldata,pg_ctl,pg_resetxlog,pg_restore,postgres,postmaster}.1
	dodoc README HISTORY doc/{README.*,TODO,bug.template}

	cd "${S}/contrib"
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}"

	dodir /etc/eselect/postgresql/slots/${SLOT}

	IDIR="${EROOT%/}/usr/include/postgresql-${SLOT}"
	cat > "${ED}/etc/eselect/postgresql/slots/${SLOT}/base" <<-__EOF__
postgres_ebuilds="\${postgres_ebuilds} ${PF}"
postgres_prefix=${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}
postgres_datadir=${EROOT%/}/usr/share/postgresql-${SLOT}
postgres_bindir=${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}/bin
postgres_symlinks=(
	${IDIR} ${EROOT%/}/usr/include/postgresql
	${IDIR}/libpq-fe.h ${EROOT%/}/usr/include/libpq-fe.h
	${IDIR}/pg_config_manual.h ${EROOT%/}/usr/include/pg_config_manual.h
	${IDIR}/libpq ${EROOT%/}/usr/include/libpq
	${IDIR}/postgres_ext.h ${EROOT%/}/usr/include/postgres_ext.h
)
__EOF__

	cat >"${T}/50postgresql-94-${SLOT}" <<-__EOF__
LDPATH=${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}/lib
MANPATH=${EROOT%/}/usr/share/postgresql-${SLOT}/man
__EOF__
	doenvd "${T}/50postgresql-94-${SLOT}"

	keepdir /etc/postgresql-${SLOT}
}

pkg_postinst() {
	eselect postgresql update
	[[ "$(eselect postgresql show)" = "(none)" ]] && eselect postgresql set ${SLOT}
	elog "If you need a global psqlrc-file, you can place it in:"
	elog "    ${EROOT%/}/etc/postgresql-${SLOT}/"
}

pkg_postrm() {
	eselect postgresql update
}
