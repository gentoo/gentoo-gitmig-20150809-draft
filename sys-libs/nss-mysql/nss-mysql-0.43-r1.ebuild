# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/nss-mysql/nss-mysql-0.43-r1.ebuild,v 1.5 2004/01/30 20:29:19 gustavoz Exp $

DESCRIPTION="NSS MySQL Module"
HOMEPAGE="http://savannah.gnu.org/projects/${PN}"
SRC_URI="http://savannah.gnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~arm ~alpha ~amd64 ~hppa ~mips ~ppc sparc"
IUSE="static"

DEPEND="virtual/glibc
	>=dev-db/mysql-3.23.51-r1"
RDEPEND="${DEPEND}
	app-arch/gzip
	sys-apps/sed
	!sys-libs/libnss-mysql"

src_compile() {
	use static && myconf="--enable-static"
	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/nss-mysql \
		--libdir=/lib \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README SHADOW THANKS TODO UPGRADE sample.sql
	newdoc ${FILESDIR}/gentoo.sql.${PN}-0.40.gentoo gentoo.sql
}

pkg_postinst() {
	einfo "Execute ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to autosetup nss-mysql and the mysql tables."
	einfo "You should then edit your /etc/nsswitch.conf file to activate nss_mysql"
	einfo "and suit your intentions. Below is an partial example:"
	einfo
	einfo "passwd:	files mysql"
	einfo "shadow:	files mysql"
	einfo "group:	files mysql"
}

pkg_config() {
	local PASS=""
	local PAS2=""
	echo "In order to continue we'll need to know a MySQL username with enough"
	echo "privleges to create databases, mysql-users and grant privleges,"
	echo "typically a user named root."
	echo
	echo -n "MySQL-root-user [root]: "
	read USERNAME
	if [ -z "${USERNAME}" ]; then
		USERNAME="root"
	fi
	echo -n "Is it required to use a password in order to access mysql with ${USERNAME} [Y/n]: "
	read NEEDPASS
	POPT="-p"
	if [ "${NEEDPASS}" == "n" ]; then
		POPT=""
	fi
	cmd="${ROOT}/usr/bin/makepasswd --minchars=10 --maxchars=12 2>/dev/null"
	if [ -z "${PASS}" -a -x "${cmd/ *}" ]; then
		einfo "makepasswd found for password generation"
		PASS=`eval $cmd`
		PAS2=`eval $cmd`
	fi
	cmd="${ROOT}/usr/bin/passook 2>/dev/null"
	if [ -z "${PASS}" -a -x "${cmd/ *}" ]; then
		einfo "passook found for password generation"
		PASS=`eval $cmd`
		PAS2=`eval $cmd`
	fi
	cmd="${ROOT}/bin/dd if=/dev/random bs=32k count=1 2>/dev/null | md5sum | awk '{print \$1}'"
	if [ -z "${PASS}" -a -x "${cmd/ *}" ]; then
		einfo "Falling back to dd and m5sum..."
		PASS=`eval $cmd``eval $cmd`
		PAS2=`eval $cmd``eval $cmd`
	fi
	if [ -z "${PASS}" ]; then
		echo "";
		echo "Didn't manage to find a passwd-generator, please type a passwords of your choise";
		echo -n "Shadow-access-password (root-only): ";
		read PASS
		echo -n "Select-public-info-password: ";
		read PAS2
	else
		einfo "shadow access password: ${PASS}"
		einfo "public access password: ${PAS2}"
	fi
	if [ -z "${PAS2}" ]; then
		PAS2="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	fi
	if [ -z "${PASS}" ]; then
		einfo "I will not accept that you leave that the shadow-access-password empty"
		die
	fi
	if [ ! -z "$POPT" ]; then
		einfo "Pass the mysql-users \"${USERNAME}\"s password to mysql:";
		echo -n "mysql> "
	fi
	( zcat /usr/share/doc/${PF}/gentoo.sql.gz | sed "s/'another_password'/'${PASS}'/g;s/'password'/'${PAS2}'/g" | mysql ${POPT} -u ${USERNAME} ) || die
	sed -e "s|shadow.db_password =.*|shadow.db_password = ${PASS};|" -i /etc/nss-mysql/nss-mysql-root.conf
	sed -e "s|users.db_password =.*|users.db_password = ${PAS2};|" -i /etc/nss-mysql/nss-mysql.conf
	chown -R 0:0 /etc/nss-mysql
	chmod 600 /etc/nss-mysql/nss-mysql-root.conf
	chmod 644 /etc/nss-mysql/nss-mysql.conf
	einfo "nss_mysql-configfiles and mysql-tables should now be setup"
	einfo "remember to activate nss-mysql in /etc/nsswitch.conf with someting simillar to:"
	einfo
	einfo "passwd:	files mysql"
	einfo "shadow:	files mysql"
	einfo "group:	files mysql"
	einfo
}
