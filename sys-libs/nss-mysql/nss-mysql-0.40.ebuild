# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/nss-mysql/nss-mysql-0.40.ebuild,v 1.11 2003/12/14 23:46:29 spider Exp $

DESCRIPTION="NSS MySQL Module"
HOMEPAGE="http://savannah.gnu.org/projects/nss-mysql"
SRC_URI="http://savannah.gnu.org/download/nss-mysql/nss-mysql.pkg/0.40/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND=">=dev-db/mysql-3.23.51-r1"
RDEPEND="${DEPEND}
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
	cp -a ${FILESDIR}/gentoo.sql.${P}.gentoo ${S}/gentoo.sql
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README SHADOW THANKS TODO UPGRADE sample.sql gentoo.sql
}

pkg_postinst() {
	einfo
	einfo "Execute ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to autosetup nss-mysql and the mysql tables."
	einfo "You should then edit your /etc/nsswitch.conf file to activate nss_mysql"
	einfo "and suit your intentions. Below is an partial example:"
	einfo
	einfo "passwd:	files mysql"
	einfo "shadow:	files mysql"
	einfo "group:	files mysql"
	einfo
}

pkg_config() {
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
	cmd="${ROOT}/usr/bin/makepasswd --minchars=10 --maxchars=12"
	if [ -f "${cmd}" ]; then
		PASS=`$cmd`
		PAS2=`$cmd`
	fi
	cmd="${ROOT}/usr/bin/passook"
	if [ -f "${cmd}" ]; then
		PASS=`$cmd`
		PAS2=`$cmd`
	fi
	if [ -z "${PASS}" ]; then
		echo "";
		echo "Didn't manage to find a passwd-generator, please type a passwords of your choise";
		echo -n "Shadow-access-password (root-only): ";
		read PASS
		echo -n "Select-public-info-password: ";
		read PAS2
	fi
	if [ -z "${PAS2}" ]; then
		PAS2="badbadbadPASSWDMHALL20020715";
	fi
	if [ -z "${PASS}" ]; then
		einfo "I will not accept that you leave that the shadow-access-password empty"
		die
	fi
	if [ ! -z "$POPT" ]; then
		einfo "Pass the mysql-users \"${USERNAME}\"s password to mysql:";
		echo -n "mysql> "
	fi
	( gunzip -c /usr/share/doc/${P}/gentoo.sql.gz | sed s/another_password/${PASS}/ | sed s/"'password'"/"'${PAS2}'"/ | mysql ${POPT} -u ${USERNAME} ) || die
	FILE="/etc/nss-mysql/nss-mysql-root.conf"; sed -e s/"shadow.db_password ="/"shadow.db_password = ${PASS};#oldpass:"/ < ${FILE} | cat > ${FILE}
	FILE="/etc/nss-mysql/nss-mysql.conf"; sed -e s/"users.db_password ="/"users.db_password = ${PAS2};#oldpass:"/ < ${FILE} | cat > ${FILE}
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
